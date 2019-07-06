# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :genres, array: true, default: []
      t.integer :popularity
      t.string :spotify_url
      t.string :spotify_identifier

      t.timestamps
    end

    add_index :artists, :genres, using: 'gin'
  end
end
