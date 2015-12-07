class CreateIndexForNameOfHost < ActiveRecord::Migration
  def change
    add_index :hosts, :name
  end
end
