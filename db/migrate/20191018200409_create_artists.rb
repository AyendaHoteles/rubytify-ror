class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :image
      t.text :genres
      t.integer :popularity
      t.string :spotify_url

      t.timestamps
    end
  end
end
