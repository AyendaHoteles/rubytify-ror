class RemoveReferenceToSongs < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:songs, :artist, index: true, foreign_key: true)
  end
end
