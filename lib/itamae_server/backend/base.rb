module ItamaeServer
  module Backend
    class Base
      def execute(execution)
        raise NotImplementedError
      end

      def hosts
        raise NotImplementedError
      end
    end
  end
end
