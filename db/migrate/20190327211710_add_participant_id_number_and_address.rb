class AddParticipantIdNumberAndAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :id_number, :string
    add_column :participants, :address, :string
  end


end
