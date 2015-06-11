class GithubWorker
  class Error < StandardError; end

  GIT_BIN = "git"
  WORKSPACE_DIR = Rails.root.join("tmp/repos")

  include Sidekiq::Worker

  def perform(payload_string)
    payload = JSON.parse(payload_string)

    clone_url = payload.fetch('repository').fetch('clone_url')

    unless permitted_clone_url?(clone_url)
      raise Error, "#{clone_url} is not permitted. Permitted URLs are #{permitted_clone_urls.inspect}"
    end

    head_commit_id = payload.fetch('head_commit').fetch('id')

    clone_uri = URI.parse(clone_url)
    clone_to = WORKSPACE_DIR.join(clone_uri.hostname, clone_uri.path.gsub(%r{\A/}, ''))

    if clone_to.exist?
      Dir.chdir(clone_to.to_s) do
        system_or_error(GIT_BIN, "fetch", "origin")
      end
    else
      FileUtils.mkdir_p(clone_to.parent.to_s)
      system_or_error(GIT_BIN, "clone", clone_url, clone_to.to_s)
    end

    Dir.chdir(clone_to.to_s) do
      system_or_error(GIT_BIN, "checkout", "-f", head_commit_id)

      revision = Revision.new(name: head_commit_id)
      revision.save!

      system_or_error("tar", "c", "--exclude", "^.git", "-f", revision.absolute_file_path.to_s, ".")
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
end

