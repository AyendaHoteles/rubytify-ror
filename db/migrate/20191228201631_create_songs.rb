class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :spotify_url
      t.string :preview_url
      t.string :duration_ms
      t.string :explicit
      t.string :spotify_id
      t.integer :album_id

      t.timestamps
    end
  end
end
