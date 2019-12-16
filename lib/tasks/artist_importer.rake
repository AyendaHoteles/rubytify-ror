require 'rest-client'

task :import => :environment do
  puts "Importing artists from Spotify"
  puts "Cleaning the database"
  Song.destroy_all
  Album.destroy_all
  Artist.destroy_all

  # authenticate application to spotify
  response = RestClient.post "https://accounts.spotify.com/api/token",
    { :grant_type => "client_credentials" },
    { :Authorization => "Basic MTg3MGQxOWI4NTRjNDNlZWI5YjIzMGM0MDlkZGU4YWI6MmU1OGRjMDUyMDFmNDhhY2JhMzNkMDFmMTdjODgyNGY=" }
  access_token = JSON.parse(response.body)["access_token"]

  artist_names = YAML.safe_load(File.read(Rails.root.join("config/artist_names.yml")))["artists"]
  if !artist_names
    puts "No artist names in config file!"
    next
  end

  artist_names.each do |artist_name|
    artist_name = artist_name.to_s
    puts artist_name

    # search for the artist
    loop do
      begin
        response = RestClient.get(
          "https://api.spotify.com/v1/search?q=#{CGI.escape(artist_name)}&type=artist",
          { :Authorization => "Bearer #{access_token}" })
        break
      rescue RestClient::TooManyRequests => exception
        sleep response.headers["Retry-After"]
      end
    end

    if JSON.parse(response)["artists"]["items"].empty?
      puts "Artist not found!"
      next
    end
    artist_data = JSON.parse(response)["artists"]["items"].first
    artist = Artist.create!(
      name: artist_data["name"],
      image: artist_data["images"].first["url"],
      genres: artist_data["genres"],
      popularity: artist_data["popularity"],
      spotify_id: artist_data["uri"].delete_prefix!("spotify:artist:"),
      spotify_url: artist_data["external_urls"]["spotify"])

    # get the artist's albums
    loop do
      begin
        response = RestClient.get(
          "https://api.spotify.com/v1/artists/#{artist.spotify_id}/albums",
          { :Authorization => "Bearer #{access_token}" })
        break
      rescue RestClient::TooManyRequests => exception
        sleep response.headers["Retry-After"]
      end
    end

    albums = []
    JSON.parse(response)["items"].each do |album_data|
      puts "** #{album_data["name"]}"
      albums.push(
        artist.albums.create!(
          name: album_data["name"],
          image: album_data["images"].first["url"],
          spotify_id: album_data["uri"].delete_prefix!("spotify:album:"),
          spotify_url: album_data["external_urls"]["spotify"],
          total_tracks: album_data["total_tracks"]))
    end

    # get each album's songs
    albums.each do |album|
      loop do
        begin
          response = RestClient.get(
            "https://api.spotify.com/v1/albums/#{album.spotify_id}/tracks",
            { :Authorization => "Bearer #{access_token}" })
          break
        rescue RestClient::TooManyRequests => exception
          sleep response.headers["Retry-After"]
        end
      end

      JSON.parse(response)["items"].each do |song_data|
        puts "**** #{song_data["name"]}"
        album.songs.create!(
          name: song_data["name"],
          explicit: song_data["explicit"],
          spotify_id: song_data["uri"].delete_prefix!("spotify:track:"),
          duration_ms: song_data["duration_ms"],
          preview_url: song_data["preview_url"],
          spotify_url: song_data["external_urls"]["spotify"])
      end
    end
  end
end
