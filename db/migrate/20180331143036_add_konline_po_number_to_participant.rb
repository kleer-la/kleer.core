class AddKonlinePoNumberToParticipant < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :konline_po_number, :string
  end
end
