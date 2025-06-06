class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.string :stripe_payment_intent_id, null: false
      t.string :status, default: 'pending'
      t.text :metadata

      t.timestamps
    end

    add_index :payments, :stripe_payment_intent_id, unique: true
    add_index :payments, :status
  end
end
