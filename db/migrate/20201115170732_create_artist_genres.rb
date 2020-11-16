class CreateArtistGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_genres do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
