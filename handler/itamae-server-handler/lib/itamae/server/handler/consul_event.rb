require 'json'
require 'base64'

module Itamae
  module Server
    module Handler
      class ConsulEvent < Struct.new(:payload)
        def self.all
          @all ||= JSON.parse($stdin.read).map do |e|
            self.new.tap do |event|
              event.payload = Base64.decode64(e.fetch('Payload'))
            end
          end
        end
      end
    end
  end
end

