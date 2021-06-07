class RenameColumnToArtists < ActiveRecord::Migration[5.2]
  def change
    rename_column(:artists, :genre, :genres)
  end
end
