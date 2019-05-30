class AddTaglineToCategory < ActiveRecord::Migration[5.2]
  def up
		add_column :categories, :tagline, :string
	end
	
	def down
		remove_column :categories, :tagline
	end
end
