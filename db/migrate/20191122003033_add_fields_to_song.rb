class AddFieldsToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :name, :string
    add_column :songs, :spotify_url, :string
    add_column :songs, :preview_url, :string
    add_column :songs, :duration_ms, :string
    add_column :songs, :explicit, :boolean
    add_column :songs, :spotify_id, :string
  end
end
