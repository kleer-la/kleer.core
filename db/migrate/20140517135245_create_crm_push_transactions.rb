class CreateCrmPushTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :crm_push_transactions do |t|
      t.references :event
      t.references :user

      t.timestamps
    end
  end
end
