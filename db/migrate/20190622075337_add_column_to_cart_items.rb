class AddColumnToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :shopping_cart_id, :integer
  end
end
