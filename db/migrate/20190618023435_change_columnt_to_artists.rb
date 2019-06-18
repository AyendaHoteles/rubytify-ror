class ChangeColumntToArtists < ActiveRecord::Migration[5.2]
  def change
    change_column :artists, :spotify_id, :string
  end
end
