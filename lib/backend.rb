require 'backend/consul'

module Backend
  def self.current
    return @current if @current

    type = ENV['BACKEND_TYPE']

    klass = case type
            when 'consul'
              Consul
            else
              raise "unknown backend: #{type}"
            end

    @current = klass.new
  end
end
