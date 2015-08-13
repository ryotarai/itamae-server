class RemoveNameFromRevision < ActiveRecord::Migration
  def change
    remove_column :revisions, :name
  end
end
