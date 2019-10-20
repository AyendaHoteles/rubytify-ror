class ChangeSpotifyIdFromAlbums < ActiveRecord::Migration[5.2]
  def up
    change_column :albums, :spotify_id, :string
  end

  def down
    change_column :albums, :spotify_id, :integer
  end
end
