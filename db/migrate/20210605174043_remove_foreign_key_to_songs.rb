class RemoveForeignKeyToSongs < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :songs, column: :artist_id
  end
end
