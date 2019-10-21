namespace :spotify do
  desc "Load artists info from spotify based on artists_data.yml"
  task load_artists: :environment do
    seed_file = Rails.root.join('db',  'artists_data.yml')
    artists = YAML::load_file(seed_file)
    artists['artists'].each do |artist_name|
        SpotifyClientService.new.find_artist(artist_name.to_s)
      end
  end
end
