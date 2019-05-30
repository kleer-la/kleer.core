class AddTagNameToTrainer < ActiveRecord::Migration[5.2]
  def change
  	add_column :trainers, :tag_name, :string
  end
end
