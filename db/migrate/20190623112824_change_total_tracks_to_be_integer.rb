class ChangeTotalTracksToBeInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :total_tracks, :integer, default: 0
  end
end
