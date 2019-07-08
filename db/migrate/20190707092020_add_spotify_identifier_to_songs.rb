class AddSpotifyIdentifierToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :spotify_identifier, :string
  end
end
