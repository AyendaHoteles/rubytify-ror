class AddNameToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :name, :string
  end
end
