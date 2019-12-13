class CreateAlbumsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.references :artist, index: true, foreign_key: true
      t.string :name, null: false
      t.string :image
      t.string :spotify_url
      t.string :spotify_id, null: false
      t.integer :total_tracks, default: 0

      t.timestamps
      t.index [:spotify_id], unique: true
    end
  end
end
