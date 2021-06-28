class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :preview_url
      t.integer :duration_ms
      t.string :spotify_url
      t.string :spotify_id
      t.string :spotify_id_album
      t.boolean :explicit
      t.string :genres

      t.timestamps
    end
  end
end
