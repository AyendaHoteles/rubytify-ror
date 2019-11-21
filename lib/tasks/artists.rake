require 'net/http'

namespace :artists do
  task upload: :environment do
    path = "./artists.yml"
    wrap = []
    Spotify.authenticate

    File.open(path) do |file|
      YAML.load_file(file)["artists"].each do |artist|
        begin
          puts "fetching: #{artist}"
          response = JSON.parse(Spotify.fetch_artist_by_name(artist).body)
          artist_item = response["artists"]["items"].find { |item| artist == item["name"] }

          if artist_item
            artist_data = {
              name: artist_item["name"],
              image:artist_item["images"].sample["url"],
              genres: artist_item["genres"],
              popularity: artist_item["popularity"],
              spotify_url: artist_item["external_urls"]["spotify"],
              spotify_id: artist_item["id"]
            }

            puts "Fetching albums for: #{artist}"
            response = JSON.parse(Spotify.fetch_artist_albumes(artist_data[:spotify_id]).body)

            albumes_items = response["items"].map do |item|
              {
                name: item["name"],
                image:item["images"].sample["url"],
                spotify_url: item["external_urls"]["spotify"],
                spotify_id: item["id"]
              }
            end || []

            albumes_items.map do |item|
              puts "Fetching songs for: #{item[:name]} by #{artist}"
              response = JSON.parse(Spotify.fetch_albumes_songs(item[:spotify_id]).body)
              tracks_items = response["items"].map do |track|
                {
                  name: track["name"],
                  spotify_url: track["external_urls"]["spotify"],
                  preview_url: track["preview_url"],
                  duration_ms: track["duration_ms"],
                  explicit: track["explicit"],
                  spotify_id: track["id"]
                }
              end || []

              item.merge({ songs_attributes: tracks_items })
            end

            artist_data.merge({ albumes_attributes: albumes_items })

            wrap << artist_data
          else
            puts "Artist: #{artist} NOT found."
          end
        rescue Errno::ETIMEDOUT => e
          puts "TIMEOUT retying."
          retry
        end
      end
    end
  end
end
