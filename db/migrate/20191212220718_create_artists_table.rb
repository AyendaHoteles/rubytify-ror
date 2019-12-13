class CreateArtistsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :image
      t.jsonb :genres
      t.integer :popularity
      t.string :spotify_url
      t.string :spotify_id, null: false

      t.timestamps
      t.index [:spotify_id], unique: true
    end
  end
end
