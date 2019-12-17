require "rest-client"

task :import => :environment do
  puts "Importing artists from Spotify"
  puts "Cleaning the database"
  Song.destroy_all
  Album.destroy_all
  Artist.destroy_all

  artist_names = YAML.safe_load(File.read(Rails.root.join("config/artist_names.yml")))["artists"]
  if !artist_names
    puts "No artist names in config file!"
    next
  end

  # authenticate application to spotify
  base64_creds =
    "MTg3MGQxOWI4NTRjNDNlZWI5YjIzMGM0MDlkZGU4YWI6MmU1OGRjMDUyMDFmNDhhY2JhMzNkMDFmMTdjODgyNGY="
  response = RestClient.post "https://accounts.spotify.com/api/token",
                             { :grant_type => "client_credentials" },
                             { :Authorization => "Basic #{base64_creds}" }
  access_token = JSON.parse(response.body)["access_token"]

  artist_names.each do |artist_name|
    artist_name = artist_name.to_s
    puts artist_name

    # search for the artist
    loop do
      begin
        response = RestClient.get(
          "https://api.spotify.com/v1/search?q=#{CGI.escape(artist_name)}&type=artist",
          { :Authorization => "Bearer #{access_token}" }
        )
        break
      rescue RestClient::TooManyRequests => exception
        sleep exception.response.headers[:retry_after].to_i
      end
    end

    if JSON.parse(response)["artists"]["items"].empty?
      puts "Artist not found!"
      next
    end
    artist_payload = JSON.parse(response)["artists"]["items"].first
    artist = Artist.create!(
      name: artist_payload["name"],
      image: artist_payload["images"].first["url"],
      genres: artist_payload["genres"],
      popularity: artist_payload["popularity"],
      spotify_id: artist_payload["id"],
      spotify_url: artist_payload["external_urls"]["spotify"],
    )

    # get the artist's albums
    loop do
      begin
        response = RestClient.get(
          "https://api.spotify.com/v1/artists/#{artist.spotify_id}/albums",
          { :Authorization => "Bearer #{access_token}" }
        )
        break
      rescue RestClient::TooManyRequests => exception
        sleep exception.response.headers[:retry_after].to_i
      end
    end

    albums_data = []
    JSON.parse(response)["items"].each do |album_payload|
      puts "** #{album_payload["name"]}"
      albums_data.push({
        name: album_payload["name"],
        image: album_payload["images"].first["url"],
        spotify_id: album_payload["id"],
        spotify_url: album_payload["external_urls"]["spotify"],
        total_tracks: 0,
      })
    end

    # get each album's songs
    albums_data.each do |album_data|
      loop do
        begin
          response = RestClient.get(
            "https://api.spotify.com/v1/albums/#{album_data[:spotify_id]}/tracks",
            { :Authorization => "Bearer #{access_token}" }
          )
          break
        rescue RestClient::TooManyRequests => exception
          sleep exception.response.headers[:retry_after].to_i
        end
      end

      songs_data = []
      JSON.parse(response)["items"].each do |song_payload|
        puts "**** #{song_payload["name"]}"
        songs_data.push({
          name: song_payload["name"],
          explicit: song_payload["explicit"],
          spotify_id: song_payload["id"],
          duration_ms: song_payload["duration_ms"],
          preview_url: song_payload["preview_url"],
          spotify_url: song_payload["external_urls"]["spotify"],
        })
      end

      # save album and songs to disk
      album_data[:total_tracks] = songs_data.size
      album = artist.albums.create!(album_data)
      album.songs.create!(songs_data)
    end
  end
end
