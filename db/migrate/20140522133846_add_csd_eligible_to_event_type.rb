class AddCsdEligibleToEventType < ActiveRecord::Migration[5.2]
  def change
  	add_column :event_types, :csd_eligible, :boolean
  end
end
