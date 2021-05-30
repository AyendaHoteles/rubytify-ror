class CreateLogsArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :logs_artists do |t|
      t.string :artist_name

      t.timestamps
    end
  end
end
