class AddHostExecutionToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :host_execution, index: true, foreign_key: true

    remove_foreign_key :events, :hosts
    remove_reference :events, :host

    remove_foreign_key :events, :executions
    remove_reference :events, :execution
  end
end
