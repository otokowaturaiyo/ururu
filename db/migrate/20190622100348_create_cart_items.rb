class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer "product_id"
      t.integer "product_count"
      t.integer "product_price"
      t.integer "cart_id"
      t.timestamps
    end
  end
end
