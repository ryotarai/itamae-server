class ChangeTypeToEventType < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :type, :event_type
    end
  end
end
