class AddResignationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :resignation, :boolean
  end
end
