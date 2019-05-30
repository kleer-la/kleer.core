class AddAverageRatingToEvent < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :average_rating, :decimal, :precision => 4, :scale => 2
  end
end
