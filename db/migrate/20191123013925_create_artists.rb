class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, nill: false
      t.string :image
      t.string :genres, array: true
      t.integer :popularity
      t.string :spotify_url
      t.string :spotify_id

      t.timestamps
    end
    add_index :artists, :genres, using: 'gin'
  end
end
