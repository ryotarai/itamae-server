class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :execution, index: true, foreign_key: true
      t.references :host, index: true, foreign_key: true
      t.string :type
      t.text :payload

      t.timestamps null: false
    end
  end
end
