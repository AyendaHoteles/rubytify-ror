require 'net/http'

namespace :artists do
  task upload: :environment do
    Artist.destroy_all
    Spotify.authenticate
    artists = fetch_artist
    albums = fetch_albums(artists)
    songs = fetch_songs(albums)
    puts "Creating in data base..."
    Artist.create(normalize_data(artists, albums, songs))
    puts "Done."
  end
end

def fetch_artist
  path = "./artists.yml"
  artists = []
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

          artists << artist_data
        else
          puts "Artist: #{artist} NOT found."
        end
      rescue Errno::ETIMEDOUT => e
        puts "TIMEOUT retying."
        retry
      end
    end
    artists
  end
end

def fetch_albums(artists)
  albums = []
  artists.each do |artist|
    begin
      puts "Fetching albums for: #{artist[:name]}"
      response = JSON.parse(Spotify.fetch_artist_albumes(artist[:spotify_id]).body)

      albumes_items = response["items"].map do |item|
        albums << {
          name: item["name"],
          image:item["images"].sample["url"],
          spotify_url: item["external_urls"]["spotify"],
          spotify_id: item["id"],
          artists_spotify_id: artist[:spotify_id]
        }
      end
    rescue Errno::ETIMEDOUT => e
      puts "TIMEOUT retying."
      retry
    end
  end
  albums
end

def fetch_songs(albums)
  songs = []
  albums.each do |album|
    begin
      puts "Fetching songs for: #{album[:name]}"
      response = JSON.parse(Spotify.fetch_albumes_songs(album[:spotify_id]).body)
      response["items"].each do |track|
        puts "-----Track #{track["name"]} by #{track["artists"].first["name"]}"
        songs << {
          name: track["name"],
          spotify_url: track["external_urls"]["spotify"],
          preview_url: track["preview_url"],
          duration_ms: track["duration_ms"],
          explicit: track["explicit"],
          spotify_id: track["id"],
          album_spotify_id: album[:spotify_id],
          artist_name: track["artists"].first["name"]
        }
      end
    rescue Errno::ETIMEDOUT => e
      puts "TIMEOUT retying."
      retry
    end
  end
  songs
end

def normalize_data(artists, albums, songs)
  puts "Total data - artists: #{artists.size} -- albums: #{albums.size} -- songs: #{songs.size}"

  group_albums = albums.group_by { |album| album[:artists_spotify_id] }
  group_songs = songs.group_by { |album| album[:album_spotify_id] }

  artists.map do |artist|
    artist_albums = group_albums[artist[:spotify_id]]
    normalize_albums = artist_albums.map do |album|
      albums_songs = group_songs[album[:spotify_id]]
      normalize_songs = albums_songs.map do |song|
        {
          name: song[:name],
          spotify_url: song[:spotify_url],
          preview_url: song[:preview_url],
          duration_ms: song[:duration_ms],
          explicit: song[:explicit],
          spotify_id: song[:spotify_id]
        }
      end
      {
        name: album[:name],
        image: album[:image],
        spotify_url: album[:spotify_url],
        total_tracks: album[:total_tracks],
        spotify_id: album[:spotify_id],
        songs_attributes: normalize_songs
      }
    end
    {
      name: artist[:name],
      image: artist[:image],
      genres: artist[:genres],
      popularity: artist[:popularity],
      spotify_url: artist[:spotify_url],
      spotify_id: artist[:spotify_id],
      albums_attributes: normalize_albums
    }
  end
end
