class DeleteFilePathFromHostExecution < ActiveRecord::Migration
  def change
    remove_column :host_executions, :file_path
  end
end
