# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :artist_id

      t.string :name,          null: false
      t.string :image,         default: ''
      t.integer :total_tracks, default: 0
      t.string :spotify_url,   null: false
      t.string :spotify_id,    null: false

      t.timestamps
    end

    add_index :albums, :spotify_id
    add_index :albums, :artist_id
  end
end
