class AddLinkedInUrlToTrainer < ActiveRecord::Migration[5.2]
  def up
		add_column :trainers, :linkedin_url, :string
	end
	
	def down
		remove_column :trainers, :linkedin_url
	end
end
