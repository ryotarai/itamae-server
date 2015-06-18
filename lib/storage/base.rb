module Storage
  class Base
    class Error < StandardError; end

    def store_file(key, file_path)
      raise NotImplementedError
    end

    def store(key, body)
      raise NotImplementedError
    end

    def url_for_file(key)
      raise NotImplementedError
    end

    def delete_file(key)
      raise NotImplementedError
    end

    def read_and_join_under(prefix)
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
