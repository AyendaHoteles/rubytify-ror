require 'rspotify'

namespace :import do
  desc "Feed DB with artist's info from Spotify"
  task spotify: :environment do
    artists_list = YAML.load_file(Rails.root.join("db", "seeds", "artists.yml"))
    
  end

end
