class RemoveColumnFromCartItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :user_id, :integer
  end
end
