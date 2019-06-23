class ChangeTotalTracksToBeInteger < ActiveRecord::Migration[5.2]
  def change
    if Rails.env.production?
      change_column :albums, :total_tracks, 'integer USING CAST(total_tracks AS integer)', default: 0
    else
      change_column :albums, :total_tracks, :integer, default: 0
    end
  end
end
