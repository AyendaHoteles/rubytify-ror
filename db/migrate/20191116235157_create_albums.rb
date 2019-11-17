class CreateAlbums < ActiveRecord::Migration[6.0]
  def up
    create_table :albums do |t|
      t.string  :name
      t.string  :image
      t.string  :spotify_url
      t.integer :total_tracks
      t.string  :spotify_id
      t.string  :artist_id
      t.string  :genres

      t.timestamps
    end
    #Change genres default string tyte to Array<string>
    change_column :albums, :genres, :string, array: true, default: nil, using: "(string_to_array(genres, ','))"
    
  end
  
  def down
    drop_table :albums
  end
end
