class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
      create_table :albums do |t|
        t.string :name
        t.string :image
        t.string :spotify_url
        t.string :total_tracks
        t.string :spotify_id
        t.references :artist, null: false, foreign_key: true

        t.timestamps
      end
  end
end
