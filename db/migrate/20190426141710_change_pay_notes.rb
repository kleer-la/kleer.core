class ChangePayNotes < ActiveRecord::Migration[5.2]
  def change
    change_column :participants, :pay_notes, :text
  end
end
