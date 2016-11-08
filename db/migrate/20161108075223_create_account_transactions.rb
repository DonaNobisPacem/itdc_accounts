class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :transaction_type
      t.decimal :amount, precision: 15, scale: 2
      t.decimal :prev_balance, precision: 15, scale: 2
      t.decimal :new_balance, precision: 15, scale: 2
      t.text :description
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
