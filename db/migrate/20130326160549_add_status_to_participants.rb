class AddStatusToParticipants < ActiveRecord::Migration[5.2]
  def up
		add_column :participants, :status, :string
	end
	
	def down
		remove_column :participants, :status
	end
end
