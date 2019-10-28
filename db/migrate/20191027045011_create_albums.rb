class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name, null: false, default: ''
      t.string :image, null: false, default: ''
      t.string :spotify_url , null: false, default: ''
      t.string :total_tracks, null: false, default: '0'
      t.string :spotify_id, null: false, default: ''
      t.references :artist, foreign_key: true

      t.timestamps
    end
    add_index :albums, :name
    add_index :albums, :spotify_id
  end
end
