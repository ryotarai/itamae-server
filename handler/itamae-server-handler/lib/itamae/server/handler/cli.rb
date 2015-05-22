require 'thor'

module Itamae
  module Server
    module Handler
      class CLI < Thor
        desc 'version', 'show version'
        def version
          puts "v#{VERSION}"
        end

        desc 'handle', 'handle Consul events'
        method_option :server_url, type: :string, required: true
        method_option :node_attribute, type: :string, required: true
        method_option :lock_name, type: :string, default: "itamae"
        method_option :lock_concurrency, type: :numeric
        def handle
          Runner.new(options).run
        end
      end
    end
  end
end
