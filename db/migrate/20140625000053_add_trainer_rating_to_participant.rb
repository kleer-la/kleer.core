class AddTrainerRatingToParticipant < ActiveRecord::Migration[5.2]
  def change
  	add_column :participants, :trainer_rating, :integer
  end
end
