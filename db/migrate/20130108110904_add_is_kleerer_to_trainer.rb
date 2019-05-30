class AddIsKleererToTrainer < ActiveRecord::Migration[5.2]
  def up
		add_column :trainers, :is_kleerer, :boolean
	end
	
	def down
		remove_column :trainers, :is_kleerer
	end
end
