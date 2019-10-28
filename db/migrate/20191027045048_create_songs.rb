class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name, null: false, default: ''
      t.string :spotify_url, null: false, default: ''
      t.string :preview_url, default: ''
      t.integer :duration_ms, null: false, default: 0
      t.boolean :explicit, default: false
      t.string :spotify_id, null: false, default: ''
      t.references :album, foreign_key: true

      t.timestamps
    end
    add_index :songs, :name
    add_index :songs, :duration_ms
    add_index :songs, :explicit
    add_index :songs, :spotify_id
  end
end
