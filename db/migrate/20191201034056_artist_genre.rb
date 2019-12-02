class ArtistGenre < ActiveRecord::Migration[5.2]
  def change
    create_table :artists_genres do |t|
      t.references :artist, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
