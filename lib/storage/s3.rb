require 'storage/base'
require 'aws-sdk'

module Storage
  class S3 < Base
    def store_file(key, file_path)
      bucket.put_object(body: open(file_path), key: generate_s3_key(key))
    end

    def url_for_file(key)
      bucket.object(generate_s3_key(key)).presigned_url(:get, expires_in: 60)
    end

    def delete_file(key)
      bucket.object(generate_s3_key(key)).delete
    end

    private

    def generate_s3_key(key)
      key = key.gsub(%r{\A/}, '')
      dir = root_directory.gsub(%r{/\z}, '')
      return key if dir.empty?
      "#{dir}/#{key}"
    end

    def bucket_name
      fetch_env('S3_BUCKET')
    end

    def root_directory
      fetch_env('S3_ROOT_DIRECTORY', '')
    end

    def bucket
      @bucket ||= resource.bucket(bucket_name)
    end

    def resource
      @resource ||= Aws::S3::Resource.new
    end
  end
end
