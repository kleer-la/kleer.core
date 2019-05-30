class AddNpsToEvent < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :net_promoter_score, :integer
  end
end
