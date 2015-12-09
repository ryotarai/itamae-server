class CreateHostExecutions < ActiveRecord::Migration
  def change
    create_table :host_executions do |t|
      t.references :host, index: true, foreign_key: true
      t.references :execution, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
