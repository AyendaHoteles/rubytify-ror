class AddSpotifyIdToAlbums < ActiveRecord::Migration[5.2]
  def self.up
    add_column :albums, :spotify_id, :string
  end

  def self.down
    add_column :albums, :spotify_id, :string
  end 
end
