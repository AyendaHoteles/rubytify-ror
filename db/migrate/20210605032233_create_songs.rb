class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :duration_ms
      t.boolean :explicit
      t.text :preview_url
      t.text :spotify_url
      t.string :spotify_id
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
