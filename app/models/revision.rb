class Revision < ActiveRecord::Base
  has_many :plans, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :file_path, presence: true

  after_initialize :set_defaults
  after_destroy :destroy_file

  def absolute_file_path
    Rails.root.join('public', file_path)
  end

  private

  def set_defaults
    self.file_path ||= File.join("files", 'recipes', "#{SecureRandom.uuid}.tar")
  end

  def destroy_file
    FileUtils.rm(self.absolute_file_path)
  end
end
