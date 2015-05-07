class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :revision, index: true, foreign_key: true
      t.integer :status
      t.boolean :is_dry_run

      t.timestamps null: false
    end
  end
end
