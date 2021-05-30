class AddCompletToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :complet, :boolean, default: false
  end
end
