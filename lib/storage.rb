require 'storage/base'
require 'storage/local'
require 'storage/s3'

module Storage
  def self.current
    return @current if @current

    type = ENV['STORAGE_TYPE'] || 'local'

    klass = case type
            when 'local'
              Local
            when 's3'
              S3
            else
              raise "unknown storage: #{type}"
            end

    @current = klass.new
  end
end
