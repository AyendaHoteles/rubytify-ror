class RemoveReferenceToArtists < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:artists, :album, index: true, foreign_key: true)
  end
end
