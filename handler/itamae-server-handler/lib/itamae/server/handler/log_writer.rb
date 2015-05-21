require 'faraday'

module Itamae
  module Server
    module Handler
      class LogWriter
        def initialize(url, endpoint)
          @endpoint = endpoint
          @conn = Faraday.new(url: url) do |f|
            f.adapter Faraday.default_adapter
          end
        end

        def write(data)
          res = @conn.put(@endpoint) do |req|
            req.body = data
          end

          unless 200 <= res.status && res.status < 300
            raise "sending log failed"
          end
        end
      end
    end
  end
end

