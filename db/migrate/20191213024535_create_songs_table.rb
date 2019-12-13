class CreateSongsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :album, index: true, foreign_key: true
      t.string :name, null: false
      t.string :spotify_url
      t.string :spotify_id, null: false
      t.string :preview_url
      t.integer :duration_ms, default: 0
      t.boolean :explicit, default: false

      t.timestamps
      t.index [:spotify_id], unique: true
    end
  end
end
