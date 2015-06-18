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
          @host_execution.mark_as('in_progress')

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

            cmd = [ITAMAE_BIN, "local", '--node-json', 'node.json', '--host_execution-level', 'debug']
            cmd << "--dry-run" if @execution.is_dry_run
            cmd << BOOTSTRAP_RECIPE_FILE

            if lock_concurrency = @options[:lock_concurrency]
              cmd = ["consul", "lock", "-n", lock_concurrency.to_s, @options[:lock_name], cmd.shelljoin]
            end

            execute_itamae(*cmd)
          end
          @host_execution.mark_as('completed')
        rescue
          @host_execution.mark_as('aborted')
          raise
        end

        private

        def execute_itamae(*cmd)
          io = MultiIO.new($stdout, @host_execution.create_writer)

          Bundler.with_clean_env do
            Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thr|
              @signal_handlers << proc do
                # consul lock can treat only INT signal properly.
                Process.kill(:INT, wait_thr[:pid])
              end

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

              @signal_handlers.pop
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
          register_trap

          event = ConsulEvent.all.last
          unless event
            puts "no Consul event"
            exit
          end

          client = APIClient.new(@options[:server_url])

          @execution = client.execution(event.payload.to_i)
          @revision = client.revision(@execution.revision_id)
          @host_execution = @execution.host_executions.first

          if @options[:once] && @host_execution.status != "pending"
            raise "This event is already executed. (#{@host_execution})"
          end

          @signal_handlers << proc do
            @host_execution.mark_as('aborted')
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

        def register_trap
          @signal_handlers = []
          [:INT, :TERM].each do |sig|
            Signal.trap(sig) do
              @signal_handlers.reverse_each do |h|
                h.call
              end

              abort
            end
          end
        end
      end
    end
  end
end

