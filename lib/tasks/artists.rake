require 'net/http'

namespace :artists do
  task upload: :environment do
    path = "./artists.yml"
    wrap = []
    Spotify.authenticate

    File.open(path) do |file|
      YAML.load_file(file)["artists"].each do |artist|
        puts "fetching: #{artist}"
        response = JSON.parse(Spotify.fetch_artist(artist).body)
        artist_item = response["artists"]["items"].find { |item| artist == item["name"] }

        if artist_item
          wrap << {
            name: artist_item["name"],
            image:artist_item["images"].sample["url"],
            genres: artist_item["genres"],
            popularity: artist_item["popularity"],
            spotify_url: artist_item["external_urls"]["spotify"],
            spotify_id: artist_item["id"]
          }
        else
          puts "Artist: #{artist} NOT found."
        end

        #puts "Fetching albums for: #{artist}"
        #puts "Fetching songs for: #{artist}"
        #puts "Fetching genres for: #{artist}"
      end
    end
  end
end
