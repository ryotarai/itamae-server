module Backend
  class Base
    def hosts
      raise NotImplementedError
    end

    def kick(plan)
      raise NotImplementedError
    end

    def abort(plan)
      raise NotImplementedError
    end
  end
end
