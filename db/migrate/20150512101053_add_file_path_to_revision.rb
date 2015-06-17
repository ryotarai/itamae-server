class AddFilePathToRevision < ActiveRecord::Migration
  def change
    add_column :revisions, :file_path, :string
  end
end
