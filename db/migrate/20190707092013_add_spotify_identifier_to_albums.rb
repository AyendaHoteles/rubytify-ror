class AddSpotifyIdentifierToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :spotify_identifier, :string
  end
end
