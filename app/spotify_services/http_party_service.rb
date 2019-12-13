class HttpPartyService
  def request_api(artists)
    body = { grant_type: "client_credentials" }
    credentials = { username: ENV["spotiy_client_id"], password: ENV["spotiy_client_secret"] }
    response = HTTParty.post("https://accounts.spotify.com/api/token", body: body, basic_auth: credentials)
    @token = response.success? ? response.parsed_response["access_token"] : ""

    artists.each do |name_artist|
      response = HTTParty.get("https://api.spotify.com/v1/search?q=#{name_artist}&type=artist&limit=1", headers: { "Accept" => "application/json", "Content-Type" => "application/json", "Authorization" => "Bearer #{@token}" })
      artist = (response.parsed_response)
      puts response
      if artist["artists"]["total"] > 0
        artist = artist["artists"]["items"].first
        create_artist(artist)
      else
        puts "#{name_artist} no exist in Spotify "
      end
    end
  end

  def create_artist(artist)
    puts "- Creating Artist  #{artist["name"]} "
    artist_new = Artist.new(name: artist["name"],
                            image: artist["images"][0],
                            genres: artist["genres"],
                            popularity: artist["popularity"],
                            spotify_url: artist["external_urls"]["spotify"],
                            spotify_id: spotify_id = artist["id"])

    if artist_new.save
      response = HTTParty.get("https://api.spotify.com/v1/artists/#{artist["id"]}/albums", headers: { "Accept" => "application/json", "Content-Type" => "application/json", "Authorization" => "Bearer #{@token}" })

      create_albums(response.parsed_response, artist_new) if response.success?
    end
  end

  def create_albums(albums, artist)
    albums["items"].each do |album|
      puts "-- Creating Album #{album["name"]} "
      album_new = Album.new(name: album["name"],
                            image: album["images"].last["url"],
                            spotify_url: album["external_urls"]["spotify"],
                            total_tracks: album["total_tracks"],
                            spotify_id: album["total_tracks"],
                            artist: artist)
      if album_new.save
        response = HTTParty.get("https://api.spotify.com/v1/albums/#{album["id"]}/tracks", headers: { "Accept" => "application/json", "Content-Type" => "application/json", "Authorization" => "Bearer #{@token}" })

        create_songs(response.parsed_response, album_new) if response.success?
      end
    end
  end

  def create_songs(songs, album_new)
    songs["items"].each do |song|
      puts song
      puts "- Creating Song #{song["name"]} "
      song_new = Song.create(name: song["name"],
                             spotify_url: song["external_urls"]["spotify"],
                             preview_url: song["preview_url"],
                             duration_ms: song["duration_ms"],
                             explicit: song["explicit"],
                             spotify_id: song["id"],
                             album: album_new)
      song_new.save
    end
  end
end
