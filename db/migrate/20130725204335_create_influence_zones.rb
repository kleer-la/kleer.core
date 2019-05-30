class CreateInfluenceZones < ActiveRecord::Migration[5.2]
  def change
    create_table :influence_zones do |t|
      t.string :zone_name
      t.string :tag_name
      t.references :country
            
      t.timestamps
    end
  end
end
