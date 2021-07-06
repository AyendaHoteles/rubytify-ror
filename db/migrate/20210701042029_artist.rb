class Artist < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :image
      t.json :genres
      t.integer :popularity
      t.text :spotify_url
      t.text :spotify_id

      t.timestamps
    end
  end
end
