class AddNotesToParticipant < ActiveRecord::Migration[5.2]
  def up
		add_column :participants, :notes, :text
	end
	
	def down
		remove_column :participants, :notes
	end
end
