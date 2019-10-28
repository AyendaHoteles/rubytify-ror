class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false, default: ''
      t.string :image, null: false, default: ''
      t.string :genres, null: false, default: ''
      t.integer :popularity, limit: 1, default: 0
      t.string :spotify_url, null: false, default: ''
      t.string :spotify_id, null: false, default: ''

      t.timestamps
    end
    add_index :artists, :name
    add_index :artists, :genres
    add_index :artists, :popularity
    add_index :artists, :spotify_id
  end
end
