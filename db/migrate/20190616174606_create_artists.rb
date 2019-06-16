class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :image
      t.text :genres, array: true, default: []
      t.integer :popularity, default: 0
      t.string :spotify_id
      t.string :spotify_url

      t.timestamps
    end
  end
end
