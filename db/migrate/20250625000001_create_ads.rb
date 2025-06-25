class CreateAds < ActiveRecord::Migration[7.1]
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.text :description
      t.text :promotional_text
      t.decimal :asking_price, precision: 10, scale: 2
      t.boolean :active, default: true
      t.datetime :expires_at
      t.string :contact_method
      t.string :contact_info
      t.integer :views_count, default: 0
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :ads, :active
    add_index :ads, :expires_at
    add_index :ads, [:user_id, :created_at]
  end
end
