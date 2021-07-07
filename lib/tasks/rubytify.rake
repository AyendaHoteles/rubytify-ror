namespace :rubytify do
  desc "get Artists, Albums & Songs info"
  task getRubitifySongs: :environment do
    login_response = Faraday.post("https://accounts.spotify.com/api/token") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.headers["Authorization"] = "Basic MmZhYTY0NWYyZDhkNGNlOGJiZDUyYzQ1ZTkwZDQwYzQ6OWFiODgzMjlmNmExNGUyNmJlNjNiZDAxMzYzOTI5YzA="
      req.body = URI.encode_www_form({ :grant_type => "client_credentials" })
    end

    token = JSON.parse(login_response.body)["access_token"]

    artists_list = YAML.load(File.read("public/artists.yml"))["artists"]
    artists_ids = ""

    for i in artists_list
      search_response = Faraday.get("https://api.spotify.com/v1/search") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
        req.params["q"] = i
        req.params["type"] = "artist"
      end
      artists_ids += "#{JSON.parse(search_response.body)["artists"]["items"][0]["id"]},"
    end

    artists_response = Faraday.get("https://api.spotify.com/v1/artists") do |req|
      req.headers["Authorization"] = "Bearer #{token}"
      req.params["ids"] = artists_ids[0..-2]
    end

    spotify_artists = JSON.parse(artists_response.body)["artists"]

    for i in spotify_artists
      new_artist = @artist = Artist.create(
        :name => i["name"],
        :image => i["images"][0]["url"],
        :genres => i["genres"],
        :popularity => i["popularity"],
        :spotify_url => i["external_urls"]["spotify"],
        :spotify_id => i["id"],
      )

      albums_first_url = "https://api.spotify.com/v1/artists/#{i["id"]}/albums"
      albums_next_url = nil

      while true
        albums_response = Faraday.get(albums_next_url == nil ? albums_first_url : albums_next_url) do |req|
          req.headers["Authorization"] = "Bearer #{token}"
        end

        spotify_albums = JSON.parse(albums_response.body)

        for album_item in spotify_albums["items"]
          new_album = @album = Album.create(
            :id_artist => new_artist.id,
            :name => album_item["name"],
            :image => album_item["images"].length() > 0 ? album_item["images"][0]["url"] : "null",
            :total_tracks => album_item["total_tracks"],
            :spotify_url => album_item["external_urls"]["spotify"],
            :spotify_id => album_item["id"],
          )

          # Songs block
          songs_first_url = "https://api.spotify.com/v1/albums/#{album_item["id"]}/tracks"
          songs_next_url = nil

          while true
            songs_response = Faraday.get(songs_next_url == nil ? songs_first_url : songs_next_url) do |req|
              req.headers["Authorization"] = "Bearer #{token}"
            end

            spotify_songs = JSON.parse(songs_response.body)

            for song_item in spotify_songs["items"]
              Song.create(
                :id_album => new_album.id,
                :name => song_item["name"],
                :spotify_url => song_item["external_urls"]["spotify"],
                :preview_url => song_item["preview_url"],
                :duration_ms => song_item["duration_ms"],
                :explicit => song_item["explicit"],
                :spotify_id => song_item["id"],
              )
            end

            songs_next_url = spotify_songs["next"] == "null" ? nil : spotify_songs["next"]
            if songs_next_url == nil
              break
            end
          end
          # Songs block
        end
        albums_next_url = spotify_albums["next"] == "null" ? nil : spotify_albums["next"]
        if albums_next_url == nil
          break
        end
      end
    end
  end
end
