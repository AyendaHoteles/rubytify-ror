class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.text :spotify_url
      t.text :preview_url
      t.integer :duration
      t.boolean :explicit
      t.text :spotify_id
      t.references :album

      t.timestamps
    end
  end
end
