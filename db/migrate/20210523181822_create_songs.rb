class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :spotify_url
      t.string :preview_url
      t.integer :duration
      t.boolean :explicit
      t.string :spotify_id
      t.references :album

      t.timestamps
    end
  end
end
