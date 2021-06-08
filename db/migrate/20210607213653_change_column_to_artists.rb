class ChangeColumnToArtists < ActiveRecord::Migration[5.2]
  def change
    change_column(:artists, :image, :json, using: 'image::JSON')
    change_column(:artists, :genres, :json, using: 'genres::JSON')
  end
end
