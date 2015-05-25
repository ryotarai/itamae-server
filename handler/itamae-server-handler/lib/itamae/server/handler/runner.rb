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
          @log.mark_as('in_progress')

          working_dir = Dir.pwd
          in_tmpdir do
            node_attribute = File.expand_path(@options[:node_attribute], working_dir)
            if File.executable?(node_attribute)
              system_or_abort(node_attribute, out: "node.json")
            else
              FileUtils.cp(node_attribute, 'node.json')
            end

            # download
            system_or_abort("wget", "-O", "recipes.tar", @revision.file_url)
            system_or_abort("tar", "xf", "recipes.tar")

            cmd = [ITAMAE_BIN, "local", '--node-json', 'node.json', '--log-level', 'debug']
            cmd << "--dry-run" if @plan.is_dry_run
            cmd << BOOTSTRAP_RECIPE_FILE

            if lock_concurrency = @options[:lock_concurrency]
              cmd = ["consul", "lock", "-n", lock_concurrency.to_s, @options[:lock_name], cmd.shelljoin]
            end

            execute_itamae(*cmd)
          end
          @log.mark_as('completed')
        rescue
          @log.mark_as('aborted')
          raise
        end

        private

        def execute_itamae(*cmd)
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

              exitstatus = wait_thr.value.exitstatus
              io.write("Itamae exited with #{exitstatus}\n")

              unless exitstatus == 0
                raise "Itamae exited with #{exitstatus}"
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
          write_pid

          event = ConsulEvent.all.last
          unless event
            puts "no Consul event"
            exit
          end

          client = APIClient.new(@options[:server_url])

          @plan = client.plan(event.payload.to_i)
          @revision = client.revision(@plan.revision_id)
          @log = @plan.logs.first

          if @options[:once] && @log.status != "pending"
            raise "This event is already executed. (#{@log})"
          end
        end

        def system_or_abort(*args)
          options = {}
          if args.last.is_a?(Hash)
            options = args.pop
          end

          puts "executing: #{args.shelljoin}"
          Bundler.with_clean_env do
            unless system(*args, options)
              raise "command failed."
            end
          end
        end

        def write_pid
          if pid_file = @options[:pid_file]
            pid_file = Pathname.new(pid_file)

            if pid_file.exist?
              puts "PID file already exists. (#{pid_file.to_s})"
              abort
            end

            open(pid_file, 'w') {|f| f.write(Process.pid.to_s) }

            at_exit { pid_file.unlink }
          end
        end
      end
    end
  end
end

