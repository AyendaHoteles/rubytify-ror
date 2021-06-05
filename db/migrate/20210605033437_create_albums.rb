class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :image
      t.integer :total_tracks
      t.text :spotify_url
      t.string :spotify_id
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
