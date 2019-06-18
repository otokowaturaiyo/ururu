class RemoveColumnUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :profile_image_url_id, :text
  end
end
