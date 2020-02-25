# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.uuid :album_id

      t.string :name,         null: false
      t.string :preview_url,  null: false
      t.integer :duration_ms, default: 0
      t.boolean :explicit,    default: false
      t.string :spotify_url,  null: false
      t.string :spotify_id,   null: false

      t.timestamps
    end

    add_index :songs, :spotify_id
    add_index :songs, :album_id
  end
end
