class RemoveTarUrlFromRevision < ActiveRecord::Migration
  def change
    remove_column :revisions, :tar_url
  end
end
