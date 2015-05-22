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

    def kick(plan)
      api(:put, "/v1/event/fire/#{event_name}", plan.id.to_s)
    end

    def abort(plan)
      api(:put, "/v1/event/fire/#{abort_event_name}", plan.id.to_s)
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
      ENV.fetch('CONSUL_SERVICE')
    end

    def event_name
      ENV['CONSUL_EVENT'] || 'itamae'
    end

    def abort_event_name
      ENV['CONSUL_ABORT_EVENT'] || 'itamae-abort'
    end

    def configure
      consul_url = ENV['CONSUL_URL'] || "http://localhost:8500"
      @conn = Faraday.new(url: consul_url) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
