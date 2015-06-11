require 'faraday'
require 'socket'

module Itamae
  module Server
    module Handler
      class APIClient
        class Error < StandardError; end

        module Response
          class Execution < Struct.new(:client, :id, :revision_id, :is_dry_run)
            def logs
              self.client.logs(execution_id: self.id)
            end
          end

          class Revision < Struct.new(:client, :id, :file_path)
            def file_url
              URI.join(client.server_url, self.file_path).to_s
            end
          end

          class Log < Struct.new(:client, :id, :status)
            def create_writer
              LogWriter.new(self)
            end

            def mark_as(status)
              self.client.update_log(self.id, status: status)
            end
          end
        end

        class LogWriter
          def initialize(log)
            @endpoint = "logs/#{log.id}/append.json"
            @conn = Faraday.new(url: log.client.server_url) do |f|
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

        attr_accessor :server_url

        def initialize(server_url)
          @server_url = server_url
          @conn ||= Faraday.new(url: @server_url) do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
        end

        def execution(id)
          res = get("/executions/#{id}.json")
          create_model_from_response(Response::Execution, res)
        end

        def revision(id)
          res = get("/revisions/#{id}.json")
          create_model_from_response(Response::Revision, res)
        end

        def logs(criteria = {})
          criteria = {host: Socket.gethostname}.merge(criteria)

          get("/logs.json", criteria).map do |res|
            create_model_from_response(Response::Log, res)
          end
        end

        def update_log(id, data = {})
          patch("/logs/#{id}.json", log: data)
        end

        private

        def create_model_from_response(klass, res)
          klass.new.tap do |model|
            model.client = self
            model.members.each do |f|
              next if f == :client
              model[f] = res.fetch(f.to_s)
            end
          end
        end

        def get(*args)
          res = @conn.get(*args)

          unless 200 <= res.status && res.status < 300
            raise Error, "API response is not 2xx. (#{res.inspect})"
          end

          JSON.parse(res.body)
        end

        def patch(*args)
          res = @conn.patch(*args)

          unless 200 <= res.status && res.status < 400
            raise Error, "API response is not 2xx or 3xx. (#{res.inspect})"
          end

          JSON.parse(res.body)
        end
      end
    end
  end
end

