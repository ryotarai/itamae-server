require 'thor'

module Itamae
  module Server
    module Handler
      class CLI < Thor
        desc 'version', 'show version'
        def version
          puts "v#{VERSION}"
        end
      end
    end
  end
end
