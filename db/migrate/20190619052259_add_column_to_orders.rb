class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :destination_name, :string
    add_column :orders, :destination_postal_code, :string
    add_column :orders, :destination_phone_number, :string
  end
end
