class AddResignedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :resigned_at, :datetime
  end
end
