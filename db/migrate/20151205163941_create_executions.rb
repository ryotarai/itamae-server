class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|
      t.references :revision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
