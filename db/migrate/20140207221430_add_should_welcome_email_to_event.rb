class AddShouldWelcomeEmailToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :should_welcome_email, :boolean, default: true
  end
end
