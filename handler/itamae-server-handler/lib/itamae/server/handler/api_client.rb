require 'faraday'
require 'socket'

module Itamae
  module Server
    module Handler
      class APIClient
        class Error < StandardError; end

        module Response
          class Plan < Struct.new(:client, :id, :revision_id, :is_dry_run)
            def logs
              self.client.logs(plan_id: self.id)
            end
          end

          class Revision < Struct.new(:client, :id, :file_path)
          end

          class Log < Struct.new(:client, :id)
            def create_writer
              LogWriter.new(self)
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

        def plan(id)
          Response::Plan.new.tap do |plan|
            res = get("/plans/#{id}.json")

            plan.client = self
            plan.members.each do |f|
              next if f == :client
              plan[f] = res.fetch(f.to_s)
            end
          end
        end

        def revision(id)
          Response::Revision.new.tap do |revision|
            res = get("/revisions/#{id}.json")

            revision.client = self
            revision.members.each do |f|
              next if f == :client
              revision[f] = res.fetch(f.to_s)
            end
          end
        end

        def logs(criteria = {})
          criteria = {host: Socket.gethostname}.merge(criteria)

          get("/logs.json", criteria).map do |res|
            Response::Log.new.tap do |log|
              log.client = self
              log.members.each do |f|
                next if f == :client
                log[f] = res.fetch(f.to_s)
              end
            end
          end
        end

        private

        def get(*args)
          res = @conn.get(*args)

          unless 200 <= res.status && res.status < 300
            raise Error, "API response is not 2xx. (#{res.inspect})"
          end

          JSON.parse(res.body)
        end
      end
    end
  end
end

