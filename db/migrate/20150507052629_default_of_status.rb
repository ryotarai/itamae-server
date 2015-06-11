class DefaultOfStatus < ActiveRecord::Migration
  def change
    change_column :executions, :status, :integer, default: 0
    change_column :logs, :status, :integer, default: 0
  end
end
