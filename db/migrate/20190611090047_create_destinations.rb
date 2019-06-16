class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :user_id
      t.string :name
      t.string :postal_code
      t.string :destination_address

      t.timestamps
    end
  end
end
