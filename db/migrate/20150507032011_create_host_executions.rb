class CreateHostExecutions < ActiveRecord::Migration
  def change
    create_table :host_executions do |t|
      t.string :host
      t.integer :status
      t.string :file_path

      t.timestamps null: false
    end
  end
end
