require 'faraday'
require 'socket'

module Itamae
  module Server
    module Handler
      class APIClient
        class Error < StandardError; end

        module Response
          class Plan < Struct.new(:id, :revision_id, :is_dry_run); end
          class Revision < Struct.new(:id, :file_path); end
          class Log < Struct.new(:id); end
        end

        def initialize(server_url)
          @conn ||= Faraday.new(url: server_url) do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
        end

        def plan(id)
          Response::Plan.new.tap do |plan|
            res = get("/plans/#{id}.json")
            plan.members.each do |f|
              plan[f] = res.fetch(f.to_s)
            end
          end
        end

        def revision(id)
          Response::Revision.new.tap do |revision|
            res = get("/revisions/#{id}.json")
            revision.members.each do |f|
              revision[f] = res.fetch(f.to_s)
            end
          end
        end

        def logs_for_plan(plan)
          criteria = {plan_id: plan.id, host: Socket.gethostname}
          get("/logs.json", criteria).map do |res|
            Response::Log.new.tap do |log|
              log.members.each do |f|
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

