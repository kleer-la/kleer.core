class AddEventRatingToParticipant < ActiveRecord::Migration[5.2]
  def change
  	add_column :participants, :event_rating, :integer
  end
end
