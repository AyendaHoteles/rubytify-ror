class DropLogsArtistsTable < ActiveRecord::Migration[5.2]
   def up
      drop_table :logs_artists
   end
   
   def down
    raise ActiveRecord::IrreversibleMigration
  end
end
