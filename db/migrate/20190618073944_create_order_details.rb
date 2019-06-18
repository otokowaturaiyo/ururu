class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :product_count
      t.integer :price
      t.integer :product_id

      t.timestamps
    end
  end
end
