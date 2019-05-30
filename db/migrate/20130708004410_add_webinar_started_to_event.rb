class AddWebinarStartedToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :webinar_started, :boolean, :default => false
	end
	
	def down
		remove_column :events, :webinar_started
	end
end
