namespace :artists do
  desc 'Populate artists database with Flighstats data'
  require 'yaml'
  YAML.load_file('artists.yml')
  task populate: :environment do
    RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], 
                      Rails.application.credentials.spotify[:client_secret])

    airports = Flightstats::Airports.active_airports
    airports.each_with_index do |airport, index|
      current = Airport.find_by(code: airport[Flightstats::Constants::IATA])
      next if current
      status = Airport.create(airport_attributes(airport))
      print '.'
      Rails.logger.info(airport: status.name, created: status.valid?)
    end
  end

  task fetch_albums: :environment do
    RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], 
                      Rails.application.credentials.spotify[:client_secret])
  
  end

  task fetch_songs: :environment do
    RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], 
                      Rails.application.credentials.spotify[:client_secret])
  end
end


  