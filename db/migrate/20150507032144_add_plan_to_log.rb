class AddPlanToLog < ActiveRecord::Migration
  def change
    add_reference :logs, :plan, index: true, foreign_key: true
  end
end
