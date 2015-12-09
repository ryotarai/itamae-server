class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
