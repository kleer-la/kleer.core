class AddSubtitleEventType < ActiveRecord::Migration[5.2]
  def change
    add_column :event_types, :subtitle, :string
  end
end
