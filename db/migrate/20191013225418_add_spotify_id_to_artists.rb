class AddSpotifyIdToArtists < ActiveRecord::Migration[5.2]
  def self.up
    add_column :artists, :spotify_id, :string
  end

  def self.down
    remove_column :artists, :spotify_id, :string
  end 
end
