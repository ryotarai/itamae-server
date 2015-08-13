require 'storage'

class Revision < ActiveRecord::Base
  has_many :executions, dependent: :destroy
  has_many :tags, as: :target

  validates :name, presence: true, uniqueness: true

  after_destroy :delete_file

  def store_file(path)
    Storage.current.store_file(file_key, path)
  end

  def file_url
    Storage.current.url_for_file(file_key)
  end

  private

  def delete_file
    Storage.current.delete_file(file_key)
  end

  def file_key
    "revisions/#{self.id}.tar.gz"
  end
end
