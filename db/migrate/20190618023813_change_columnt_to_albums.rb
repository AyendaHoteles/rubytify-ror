class ChangeColumntToAlbums < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :spotify_id, :string
    change_column :songs, :spotify_id, :string
  end
end
