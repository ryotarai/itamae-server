class ChangeDefaultOfDryRun < ActiveRecord::Migration
  def change
    change_column_default :executions, :dry_run, true
  end
end
