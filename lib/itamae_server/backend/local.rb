module ItamaeServer
  module Backend
    class Local < Base
      def initialize(*)
        super
        require 'tmpdir'
      end

      def execute(execution)
        Dir.mktmpdir do |dir|
          Dir.chdir(dir) do
            generate_config(execution)
            url = execution.revision.url
            system_or_abort "curl", "-L", "-o", "dest", url
            system_or_abort "tar", "xf", "dest"
            system_or_abort "itamae", "local", "-c", "config.yml", "bootstrap.rb"
          end
        end
      end

      private def system_or_abort(*args)
        unless system(*args)
          raise "#{args} failed"
        end
      end

      private def generate_config(execution)
        config = {
          'reporters' => [
            {
              'type' => 'itamae_server',
              'url' => Rails.application.routes.url_helpers.execution_events_url(execution),
            },
          ],
        }
        File.write('config.yml', config.to_yaml)
      end
    end
  end
end

