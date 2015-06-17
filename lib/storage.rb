require 'storage/base'
require 'storage/local'

module Storage
  def self.current
    return @current if @current

    type = ENV['STORAGE_TYPE'] || 'local'

    klass = case type
            when 'local'
              Local
            else
              raise "unknown storage: #{type}"
            end

    @current = klass.new
  end
end
