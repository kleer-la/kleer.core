class AddTestimonyToParticipant < ActiveRecord::Migration[5.2]
  def change
  	add_column :participants, :testimony, :text
  end
end
