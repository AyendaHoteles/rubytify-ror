# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :genres, array: true, default: []
      t.integer :popularity, default: 0
      t.string :spotify_url, null: false
      t.string :spotify_id, null: false

      t.timestamps
    end

    add_index :artists, :spotify_id
  end
end
