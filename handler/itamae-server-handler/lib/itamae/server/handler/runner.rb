require 'faraday'
require 'socket'
require 'shellwords'
require 'open3'

module Itamae
  module Server
    module Handler
      class Runner
        ITAMAE_BIN = 'itamae'
        BOOTSTRAP_RECIPE_FILE = 'bootstrap.rb'
        CONSUL_LOCK_PREFIX = 'itamae'

        class Error < StandardError; end

        def initialize(options)
          @options = options

          prepare
        end

        def run
          working_dir = Dir.pwd

          in_tmpdir do
            node_attribute = File.expand_path(@options[:node_attribute], working_dir)
            if File.executable?(node_attribute)
              system_or_abort(node_attribute, out: "node.json")
            else
              FileUtils.cp(node_attribute, 'node.json')
            end

            # download
            system_or_abort("wget", "-O", "recipes.tar", URI.join(@options[:server_url], @revision.file_path).to_s)
            system_or_abort("tar", "xf", "recipes.tar")

            itamae_cmd = [ITAMAE_BIN, "local", '--node-json', 'node.json', '--log-level', 'debug']
            itamae_cmd << "--dry-run" if @plan.is_dry_run
            itamae_cmd << BOOTSTRAP_RECIPE_FILE

            consul_cmd = ["consul", "lock", "-n", "1", CONSUL_LOCK_PREFIX, itamae_cmd.map(&:shellescape).join(' ')]

            execute_with_logger(*consul_cmd)
          end
        end

        private

        def execute_with_logger(*cmd)
          io = MultiIO.new($stdout, @log.create_writer)

          Bundler.with_clean_env do
            Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thr|
              stdin.close
              readers = [stdout, stderr]
              while readers.any?
                ready = IO.select(readers, [], readers)
                ready[0].each do |fd|
                  if fd.eof?
                    fd.close
                    readers.delete(fd)
                  else
                    io.write(fd.readpartial(1024))
                  end
                end
              end
            end
          end
        end

        def in_tmpdir
          Dir.mktmpdir do |tmpdir|
            Dir.chdir(tmpdir) do
              puts "(in #{tmpdir})"
              yield
            end
          end
        end

        def prepare
          event = ConsulEvent.all.last
          unless event
            puts "no Consul event"
            exit
          end

          client = APIClient.new(@options[:server_url])

          @plan = client.plan(event.payload.to_i)
          @revision = client.revision(@plan.revision_id)
          @log = @plan.logs.first
        end

        def system_or_abort(*args)
          options = {}
          if args.last.is_a?(Hash)
            options = args.pop
          end

          puts "executing: #{args.map(&:shellescape).join(' ')}"
          Bundler.with_clean_env do
            unless system(*args, options)
              raise "command failed."
            end
          end
        end
      end
    end
  end
end

