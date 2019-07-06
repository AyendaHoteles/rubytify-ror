class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :album, foreign_key: true
      t.string :name
      t.string :spotify_url
      t.string :preview_url
      t.integer :duration_ms
      t.boolean :explicit, default: false

      t.timestamps
    end
  end
end
