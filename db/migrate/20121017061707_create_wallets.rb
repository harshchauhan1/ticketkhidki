class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.float :money
      t.integer :user_id
 
      t.timestamps
    end
  end
end
