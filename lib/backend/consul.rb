module Backend
  class Consul
    def hosts
      Diplomat::Service.get(service_name, :all).map(&:Node)
    end

    private

    def service_name
      ENV.fetch('CONSUL_SERVICE')
    end
  end
end
