class AddIndexToGenres < ActiveRecord::Migration[5.2]
  def change
    add_index :genres, :name
  end
end
