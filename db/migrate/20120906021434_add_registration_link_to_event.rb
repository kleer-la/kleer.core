class AddRegistrationLinkToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :registration_link, :string
	end
	
	def down
		remove_column :events, :registration_link
	end
end
