module Backend
  class Base
    def hosts
      raise NotImplementedError
    end

    def kick(execution)
      raise NotImplementedError
    end

    def abort(execution)
      raise NotImplementedError
    end
  end
end
