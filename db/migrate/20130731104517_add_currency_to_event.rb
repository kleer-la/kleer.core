class AddCurrencyToEvent < ActiveRecord::Migration[5.2]
  def up
		add_column :events, :currency_iso_code, :string
	end
	
	def down
		remove_column :events, :currency_iso_code
	end
end
