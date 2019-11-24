require 'rspotify'

namespace :import do
  desc "Feed DB with artist's info from Spotify"
  task spotify: :environment do
    artists_list = YAML.load_file(Rails.root.join("db", "seeds", "artists.yml"))
    artists_list["artists"].each do |artist|
        artist_info = RSpotify::Artist.search(artist.to_s).first
        if artist_info
            artist = create_artist(artist_info)
            create_artist_albums(artist_info.albums, artist)
        else
            puts "Artist #{artist} not found"
        end
    end
  end

end
