class AddTimeZoneNameToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :time_zone_name, :string
	end
	
	def down
		remove_column :events, :time_zone_name
	end
end
