class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :image
      t.integer :total_tracks, default: 0
      t.string :spotify_id
      t.string :spotify_url
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
