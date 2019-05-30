class AddKindToView < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_views, :element_viewed, :string

    CampaignView.reset_column_information

    CampaignView.all.each do |cv|
      cv.update_attribute(:element_viewed, "landing")
    end
  end
end
