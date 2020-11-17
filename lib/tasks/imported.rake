require 'colorize'
desc "Imported data from Spotify"
namespace :imported do
  task :import_artists_and_albums_spotify => :environment do
    puts "Start Importation".colorize(:blue)
    list_artists = YAML.load_file(Rails.root.join('config', 'artists_list.yml'))
    spotify_service = SpotifyService.new
    list_artists['artists'].each do |art|
      puts "Importe #{art}".colorize(:yellow)
      spotify_service.migration_data_by_artist(art)
    end
  end
end
