require 'backend/base'
require 'backend/consul'

module Backend
  def self.current
    return @current if @current

    type = ENV['BACKEND_TYPE']

    klass = case type
            when nil
              raise "please set backend type by ENV['BACKEND_TYPE']"
            when 'consul'
              Consul
            else
              raise "unknown backend: #{type}"
            end

    @current = klass.new
  end
end
