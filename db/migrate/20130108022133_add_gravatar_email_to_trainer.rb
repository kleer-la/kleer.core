class AddGravatarEmailToTrainer < ActiveRecord::Migration[5.2]
  def up
		add_column :trainers, :gravatar_email, :string
	end
	
	def down
		remove_column :trainers, :gravatar_email
	end
end
