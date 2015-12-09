module ItamaeServer
  module Backend
    def self.instance
      @instance ||= create_instance
    end

    def self.create_instance
      klass = self.const_get(Figaro.env.backend.camelcase)
      klass.new
    end
  end
end

