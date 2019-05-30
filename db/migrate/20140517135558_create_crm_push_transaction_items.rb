class CreateCrmPushTransactionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :crm_push_transaction_items do |t|
      t.references :crm_push_transaction
      t.references :participant
      t.text :log
      t.string :result

      t.timestamps
    end
  end
end
