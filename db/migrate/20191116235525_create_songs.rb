class CreateSongs < ActiveRecord::Migration[6.0]
  def up
    create_table :songs do |t|
      t.string  :name
      t.string  :spotify_url
      t.string  :preview_url
      t.integer :duration_ms
      t.boolean :explicit
      t.string  :spotify_id
      t.string  :album_id
      t.string  :genres

      t.timestamps
    end
    #Change genres default string tyte to Array<string>
    change_column :songs, :genres, :string, array: true, default: nil, using: "(string_to_array(genres, ','))"
    
  end
  
  def down
    drop_table :songs
  end
end
