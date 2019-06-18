class ChangeNameToAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :spofity_url, :spotify_url
  end
end
