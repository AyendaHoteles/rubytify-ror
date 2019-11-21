class AddReferences < ActiveRecord::Migration[5.2]
  def change
  	add_reference :albums, :artist, index: true
  	add_reference :songs, :album, index: true
  end
end
