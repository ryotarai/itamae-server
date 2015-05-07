class DefaultOfStatus < ActiveRecord::Migration
  def change
    change_column :plans, :status, :integer, default: 0
    change_column :logs, :status, :integer, default: 0
  end
end
