class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer  :genre_id
      t.integer  :album_id
      t.string   :name
      t.string   :spotify_url
      t.string   :preview_url
      t.integer  :duration_ms
      t.boolean  :explicit
      
      t.timestamps
    end
  end
end
