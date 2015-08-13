require 'backend/base'

module Backend
  class Consul < Base
    def initialize
      configure
    end

    def hosts
      api(:get, "/v1/catalog/service/#{service_name}").map do |h|
        h.fetch('Node')
      end
    end

    def kick(execution)
      api(:put, "/v1/event/fire/#{event_name}", {"execution_id" => execution.id.to_s}.to_json)
    end

    private

    def api(method, endpoint, body = nil)
      res = @conn.public_send(method) do |req|
        req.url(endpoint)
        req.body = body if body
      end

      unless 200 <= res.status && res.status < 300
        raise "error: #{res}"
      end

      JSON.parse(res.body)
    end

    def service_name
      fetch_env('CONSUL_SERVICE')
    end

    def event_name
      fetch_env('CONSUL_EVENT', 'itamae')
    end

    def configure
      consul_url = fetch_env('CONSUL_URL', "http://localhost:8500")
      @conn = Faraday.new(url: consul_url) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
