class AddFieldsToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :name, :string
    add_column :artists, :image, :string
    add_column :artists, :genres, :text
    add_column :artists, :popularity, :string
    add_column :artists, :spotify_url, :string
    add_column :artists, :spotify_id, :string
    add_column :albums, :name, :string
    add_column :albums, :image, :string
    add_column :albums, :spotify_url, :string
    add_column :albums, :total_tracks, :string
    add_column :albums, :spotify_id, :string
    add_column :songs, :name, :string
    add_column :songs, :spotify_url, :string
    add_column :songs, :preview_url, :string
    add_column :songs, :duration_ms, :string
    add_column :songs, :explicit, :boolean
    add_column :songs, :spotify_id, :string
  end
end
