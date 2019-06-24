class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.integer :artist_id
      t.integer :label_id
      t.string :product_name
      t.string :jacket_image
      t.integer :price
      t.text :description
      t.integer :stock
      t.boolean :recommend

      t.timestamps
    end
  end
end
