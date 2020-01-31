class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :preview_url
      t.integer :duration_ms
      t.string :spotify_id
      t.string :spotify_url
      t.boolean :explicit
      t.belongs_to :album
      t.belongs_to :artist

      t.timestamps
    end
    add_column :albums, :spotify_url, :string
  end
end
