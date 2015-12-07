class AddDryRunToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :dry_run, :boolean
  end
end
