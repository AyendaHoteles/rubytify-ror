namespace :artists do
  desc 'Populate artists database with Spotify data'
  task fetch_information_and_albums: :environment do
  	SpotifyFetcher.new.execute
  end
end


  