namespace :artists do
  task :import => :environment do
    artists_file = Rails.root.join('storage', 'files_to_import', 'artists.yml')
    artists = YAML::load_file(artists_file)
    artists['artists'].each do |artist|
      SpotifyService.new.search_artist(artist.to_s)
    end
  end
end