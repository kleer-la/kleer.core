class AddSignatureAndCredentialsToTrainer < ActiveRecord::Migration[5.2]
  def change
  	add_column :trainers, :signature_image, :string
  	add_column :trainers, :signature_credentials, :string
  end
end
