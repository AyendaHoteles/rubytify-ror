class ChangeTotalTracksTypeInAlbums < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :total_tracks, 'integer USING CAST(total_tracks AS integer)'
  end
end
