class AddTrainer2RatingToParticipant < ActiveRecord::Migration[5.2]
  def change
      add_column :participants, :trainer2_rating, :integer
    end
end
