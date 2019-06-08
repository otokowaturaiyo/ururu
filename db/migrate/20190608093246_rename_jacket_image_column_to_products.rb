class RenameJacketImageColumnToProducts < ActiveRecord::Migration[5.2]
  def change
  	rename_column :products, :jacket_image, :jacket_image_id
  end
end
