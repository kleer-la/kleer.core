class CreateCampaignViews < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_views do |t|
      t.string :source
      t.references :campaign
      t.references :event

      t.timestamps
    end
  end
end
