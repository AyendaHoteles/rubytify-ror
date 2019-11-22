class AddFieldsToAlbum < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :name, :string
    add_column :albums, :image, :string
    add_column :albums, :spotify_url, :string
    add_column :albums, :total_tracks, :string
    add_column :albums, :spotify_id, :string
  end
end
