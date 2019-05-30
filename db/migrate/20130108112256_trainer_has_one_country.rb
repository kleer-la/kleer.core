class TrainerHasOneCountry < ActiveRecord::Migration[5.2]
  def up
		add_column :trainers, :country_id, :integer
  end

	def down
		remove_column :trainers, :country_id
	end
end
