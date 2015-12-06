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
            url = execution.revision.url
            sys "curl", "-L", "-o", "dest", url
            sys "tar", "xf", "dest"
            sys "itamae", "local", "bootstrap.rb"
          end
        end
      end

      private def sys(*args)
        unless system(*args)
          raise "#{args} failed"
        end
      end
    end
  end
end

