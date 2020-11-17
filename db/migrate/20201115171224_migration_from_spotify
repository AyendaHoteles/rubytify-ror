class MigrationFromSpotify < ActiveRecord::Migration[5.2]
  def change
    list_artists = YAML.load_file(Rails.root.join('config', 'artists_list.yml'))
    spotify_service = SpotifyService.new
    list_artists['artists'].each do |art|
      spotify_service.migration_data_by_artist(art)
    end
  end
end
