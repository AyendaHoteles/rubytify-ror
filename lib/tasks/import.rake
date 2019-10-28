namespace :import do
  desc "Load data from spotify app and yml file with artist name"
  task spotify_data: :environment do
    Spotify.load_data
  end

end
