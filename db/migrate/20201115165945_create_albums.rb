class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.references :artist, null: false, foreign_key: true
      t.string :image
      t.integer :total_tracks
      t.string :spotify_url
      t.string :spotify_id

      t.timestamps
    end
  end
end
