class DeleteFilePathFromRevision < ActiveRecord::Migration
  def change
    remove_column :revisions, :file_path
  end
end
