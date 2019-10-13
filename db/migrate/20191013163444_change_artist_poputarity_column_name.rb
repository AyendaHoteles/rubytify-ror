class ChangeArtistPoputarityColumnName < ActiveRecord::Migration[5.2]
   def change
    rename_column :artists, :poputarity , :popularity
  end
end
