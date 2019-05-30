class AddElevatorPitchToEventType < ActiveRecord::Migration[5.2]
  def up
		add_column :event_types, :elevator_pitch, :text
	end
	
	def down
		remove_column :event_types, :elevator_pitch
	end
end
