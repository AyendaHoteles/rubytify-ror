namespace :insert_spotify_data do

  task save_data: :environment do
    puts 'processing...'
    InsertSpotifyData.new.save_data
    puts 'Finished process.'
  end
end
