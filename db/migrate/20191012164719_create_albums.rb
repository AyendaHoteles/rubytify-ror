class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string  :name
      t.string  :image
      t.string  :spotify_url
      t.integer :total_tracks

      t.timestamps
    end
  end
end
