class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
