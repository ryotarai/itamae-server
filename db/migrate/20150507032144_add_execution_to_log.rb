class AddExecutionToLog < ActiveRecord::Migration
  def change
    add_reference :logs, :execution, index: true, foreign_key: true
  end
end
