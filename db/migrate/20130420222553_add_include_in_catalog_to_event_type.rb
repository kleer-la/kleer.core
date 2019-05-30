class AddIncludeInCatalogToEventType < ActiveRecord::Migration[5.2]
  def up
		add_column :event_types, :include_in_catalog, :boolean
	end
	
	def down
		remove_column :event_types, :include_in_catalog
	end
end
