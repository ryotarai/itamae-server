module Backend
  class Consul
    def initialize
      configure
    end

    def hosts
      Diplomat::Service.new.get(service_name, :all).map(&:Node)
    end

    private

    def service_name
      ENV.fetch('CONSUL_SERVICE')
    end

    def configure
      Diplomat.configure do |config|
        config.url = ENV['CONSUL_HOST'] if ENV['CONSUL_HOST'] # e.g. "http://localhost:8500"
      end
    end
  end
end
