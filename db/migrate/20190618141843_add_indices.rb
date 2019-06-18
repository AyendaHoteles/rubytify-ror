class AddIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :albums, :name
    add_index :songs, :name
    add_index :artists, :name
    add_index :artists, :genres
  end
end
