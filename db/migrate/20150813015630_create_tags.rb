class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :key
      t.string :value
      t.references :target, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
