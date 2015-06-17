require 'storage/base'

module Storage
  class Local < Base
    def store_file(key, file_path)
      dst = absolute_path(key)
      FileUtils.mkdir_p(dst.parent)
      FileUtils.cp(file_path, dst)
    end

    def url_for_file(key)
      "/files/#{sanitize_key(key)}"
    end

    def delete_file(key)
      FileUtils.rm_f(absolute_path(key))
    end

    private

    def absolute_path(key)
      dir.join(sanitize_key(key))
    end

    def dir
      public_dir.join('files')
    end

    def public_dir
      Rails.root.join('public')
    end

    def sanitize_key(key)
      key.gsub(%r{\A/}, '')
    end
  end
end
