class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.json :image
      t.numeric :total_tracks
      t.string :spotify_url
      t.string :spotify_id

      t.timestamps
    end
  end
end
