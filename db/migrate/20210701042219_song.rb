class Song < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :id_album
      t.string :name
      t.text :spotify_url
      t.text :preview_url
      t.integer :duration_ms
      t.boolean :explicit
      t.text :spotify_id

      t.timestamps
    end
  end
end
