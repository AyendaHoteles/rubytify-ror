class AddArtistIdToAlbums < ActiveRecord::Migration[5.2]
  def change
  	add_column :albums, :artist_id, :bigint
  end
end
