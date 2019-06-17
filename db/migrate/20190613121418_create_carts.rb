class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :product_count
      t.integer :product_price

      t.timestamps
    end
  end
end