class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name, nil: false
      t.string :image
      t.string :spotify_url
      t.integer :total_tracks
      t.string :spotify_id
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
