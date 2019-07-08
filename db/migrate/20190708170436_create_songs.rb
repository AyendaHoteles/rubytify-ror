class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :album, foreign_key: true
      t.string :name
      t.text :spotify_url
      t.text :preview_url
      t.integer :duration_ms
      t.boolean :explicit
      t.string :spotify_id

      t.timestamps
    end
  end
end
