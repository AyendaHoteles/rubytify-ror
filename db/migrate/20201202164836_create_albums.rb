class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :image
      t.text :spotify_url
      t.integer :total_tracks
      t.text :spotify_id

      t.timestamps
    end
  end
end
