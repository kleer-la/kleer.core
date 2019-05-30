class AddNotifyWebinarStartToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :notify_webinar_start, :boolean, :default => false
	end
	
	def down
		remove_column :events, :notify_webinar_start
	end
end
