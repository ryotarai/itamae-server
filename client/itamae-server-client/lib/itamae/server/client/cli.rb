require 'thor'

module Itamae
  module Server
    module Handler
      class CLI < Thor
        def self.define_run_method_options
          method_option :server_url, type: :string, required: true
          method_option :node_attribute, type: :string, required: true
          method_option :lock_name, type: :string, default: "itamae"
          method_option :lock_concurrency, type: :numeric
        end

        class_option :pid_file, type: :string

        def initialize(*args)
          super

          create_pid_file
        end

        desc 'version', 'show version'
        def version
          puts "v#{VERSION}"
        end

        desc 'apply', 'run Itamae'
        define_run_method_options
        def apply
        end

        desc 'consul', 'handle Consul events'
        define_run_method_options
        method_option :once, type: :boolean, default: true, desc: 'for debugging'
        def consul
          Runner.new(options).run
        end

        private

        def create_pid_file
          if pid_file = options[:pid_file]
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
