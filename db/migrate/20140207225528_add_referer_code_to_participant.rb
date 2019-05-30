class AddRefererCodeToParticipant < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :referer_code, :string
  end
end
