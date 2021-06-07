class ChangeColumnToArtists < ActiveRecord::Migration[5.2]
  def change
    change_column(:artists, :image, :json)
    change_column(:artists, :genres, :json)
  end
end
