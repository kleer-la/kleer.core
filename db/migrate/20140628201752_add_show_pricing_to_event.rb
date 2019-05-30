class AddShowPricingToEvent < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :show_pricing, :boolean, :default => false
  end
end
