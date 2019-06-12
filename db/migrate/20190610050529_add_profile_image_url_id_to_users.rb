class AddProfileImageUrlIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image_url_id, :text
  end
end
