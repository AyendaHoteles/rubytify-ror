require 'rspotify'

task :import => :environment do
    RSpotify.authenticate("1870d19b854c43eeb9b230c409dde8ab", "2e58dc05201f48acba33d01f17c8824f")
    artist_names = YAML::load(File.read(Rails.root.join('config/artist_names.yml')))["artists"]
    artist_names.each do |artist_name|
        if !(artist_name.instance_of? String) then
            artist_name = artist_name.to_s
        end
        results = RSpotify::Artist.search(artist_name, limit: 1)
        if results.total == 0 then
            puts "Artist '#{artist_name}' not found!"
            next
        end
        artist_data = results.first
        artist = Artist.new
        artist.name = artist_data.name;
        artist.image = artist_data.images.first
        artist.genres = artist_data.genres
        artist.popularity = artist_data.popularity
        artist.spotify_url = artist_data.external_urls["spotify"]
        artist.spotify_id = artist_data.uri.delete_prefix! "spotify:artist:"
        artist.save!
    end
end