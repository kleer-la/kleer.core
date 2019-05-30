class AddMonitorEmailToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :monitor_email, :string
  end
end
