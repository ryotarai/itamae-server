require 'tmpdir'

class GithubWorker
  class Error < StandardError; end

  GIT_BIN = "git"
  WORKSPACE_DIR = Rails.root.join("tmp/repos")

  include Sidekiq::Worker

  def perform(event_type, payload_string)
    payload = JSON.parse(payload_string)

    event = case event_type
            when 'push'
              parse_push_payload(payload)
            when 'pull_request'
              parse_pull_request_payload(payload)
            else
              raise Error, "Unsupported GitHub event: #{event_type}"
            end

    if event_type == 'pull_request' && event[:action] != 'opened'
    end

    unless permitted_clone_url?(event[:clone_url])
      raise Error, "#{event[:clone_url]} is not permitted. Permitted URLs are #{permitted_clone_urls.inspect}"
    end

    clone_uri = URI.parse(event[:clone_url])
    clone_to = WORKSPACE_DIR.join(clone_uri.hostname, clone_uri.path.gsub(%r{\A/}, ''))

    if clone_to.exist?
      Dir.chdir(clone_to.to_s) do
        system_or_error(GIT_BIN, "fetch", "origin")
      end
    else
      FileUtils.mkdir_p(clone_to.parent.to_s)
      system_or_error(GIT_BIN, "clone", event[:clone_url], clone_to.to_s)
    end

    Dir.chdir(clone_to.to_s) do
      system_or_error(GIT_BIN, "checkout", "-f", event[:head_commit_id])

      revision = Revision.create!
      revision.tags.create!(key: "commit_id", value: event[:head_commit_id])

      Dir.chdir(recipe_directory) do
        Dir.mktmpdir do |tmpdir|
          tmppath = File.join(tmpdir, "recipes.tar")
          system_or_error("tar", "c", "--exclude", "^.git", "-f", tmppath, ".")
          revision.store_file(tmppath)
        end
      end
    end
  end

  private

  def system_or_error(*args)
    Rails.logger.debug("system_or_error(#{args})")
    unless system(*args)
      raise Error, "failed: #{args}"
    end
  end

  def permitted_clone_urls
    if urls = ENV['PERMITTED_CLONE_URLS']
      urls.split(',')
    else
      []
    end
  end

  def permitted_clone_url?(url)
    permitted_clone_urls.empty? || permitted_clone_urls.include?(url)
  end

  def recipe_directory
    ENV['RECIPE_DIRECTORY'] || '.'
  end

  def parse_push_payload(payload)
    {
      clone_url: payload.fetch('repository').fetch('clone_url'),
      head_commit_id: payload.fetch('head_commit').fetch('id'),
    }
  end

  def parse_pull_request_payload(payload)
    {
      action: payload.fetch('action'),
      clone_url: payload.fetch('pull_request').fetch('head').fetch('repo').fetch('clone_url'),
      head_commit_id: payload.fetch('pull_request').fetch('head').fetch('sha'),
    }
  end
end
