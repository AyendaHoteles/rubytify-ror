class AddImageToArtistsAndAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :image, :text
    add_column :albums, :image, :text
  end
end
