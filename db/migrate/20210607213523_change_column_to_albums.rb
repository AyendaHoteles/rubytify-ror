class ChangeColumnToAlbums < ActiveRecord::Migration[5.2]
  def change
    change_column(:albums, :image, :json, using: 'image::JSON')
  end
end
