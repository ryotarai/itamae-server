module Storage
  class Base
    def store_file(key, file_path)
      raise NotImplementedError
    end

    def url_for_file(key)
      raise NotImplementedError
    end

    def delete_file(key)
      raise NotImplementedError
    end
  end
end
