class ChangeDefaultOfStatusOfExecution < ActiveRecord::Migration
  def change
    change_column_default :executions, :status, 1
  end
end
