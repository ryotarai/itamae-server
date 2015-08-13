module Backend
  class Base
    def kick(execution)
      raise NotImplementedError
    end

    private

    def fetch_env(key, default = nil)
      value = ENV[key] || default

      unless value
        raise Error, "'#{key}' is not set."
      end

      value
    end
  end
end
