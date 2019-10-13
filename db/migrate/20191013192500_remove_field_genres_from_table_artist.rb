class RemoveFieldGenresFromTableArtist < ActiveRecord::Migration[5.2]
   def up
    remove_column :artists, :genres
  end

  def down
    add_column :artists, :genres, :string
  end
end
