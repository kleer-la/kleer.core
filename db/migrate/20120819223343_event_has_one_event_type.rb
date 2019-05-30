class EventHasOneEventType < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :event_type_id, :integer
  end

	def down
		remove_column :events, :event_type_id
	end
end
