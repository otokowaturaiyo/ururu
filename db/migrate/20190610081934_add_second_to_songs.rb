class AddSecondToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :second, :string
  end
end
