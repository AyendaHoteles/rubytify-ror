class AddReferenceToArtist < ActiveRecord::Migration[5.2]
  def change
    add_reference :artists, :album, foreign_key: true
  end
end
