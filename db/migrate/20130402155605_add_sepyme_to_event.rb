class AddSepymeToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :sepyme_enabled, :boolean
	end
	
	def down
		remove_column :events, :sepyme_enabled
	end
end
