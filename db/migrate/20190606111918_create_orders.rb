class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :payment_methods
      t.string :shipment_status
      t.string :destination
      t.integer :user_id

      t.timestamps
    end
  end
end
