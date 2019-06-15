class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :spofity_url
      t.integer :total_tracks
      t.integer :spotify_id
      t.string :image
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
