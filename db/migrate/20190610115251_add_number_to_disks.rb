class AddNumberToDisks < ActiveRecord::Migration[5.2]
  def change
    add_column :disks, :number, :integer
  end
end
