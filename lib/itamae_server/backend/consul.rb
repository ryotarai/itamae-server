module ItamaeServer
  module Backend
    class Consul < Base
      def initialize(*)
        super
        require 'diplomat'
      end

      def execute(execution)
        Diplomat::Event.fire(event_name, payload(execution))
      end

      def hosts
        Diplomat::Node.get_all.map {|n| n.Node }
      end

      private def event_name
        Figaro.env.consul_event_name || 'itamae-server'
      end

      private def secret_key
        Figaro.env.consul_secret_key
      end

      private def payload(execution)
        result = {
          "recipe_url" => execution.revision.url,
          "itamae_server_url" => Rails.application.routes.url_helpers.bulk_execution_events_url(execution),
        }.to_json

        if secret_key
          hmac = OpenSSL::HMAC.hexdigest("sha256", secret_key, result)
          result << "\n#{hmac}"
        end

        result
      end
    end
  end
end

