class AddExecutionToHostExecution < ActiveRecord::Migration
  def change
    add_reference :host_executions, :execution, index: true, foreign_key: true
  end
end
