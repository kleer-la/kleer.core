class AddGoalToEventType < ActiveRecord::Migration[5.2]
  def up
		add_column :event_types, :goal, :text
	end
	
	def down
		remove_column :event_types, :goal
	end
end
