class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :codename, :index => true
      t.text :description

      t.timestamps
    end
  end
end
