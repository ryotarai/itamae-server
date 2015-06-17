require 'storage'

class Revision < ActiveRecord::Base
  has_many :executions, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_destroy :delete_file

  def store_file(path)
    Storage.current.store_file(file_key, path)
  end

  private

  def delete_file
    Storage.current.delete_file(file_key)
  end

  def file_key
    "revisions/#{self.id}.tar.gz"
  end
end
