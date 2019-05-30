class AddExtraScriptToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :extra_script, :text
  end
end
