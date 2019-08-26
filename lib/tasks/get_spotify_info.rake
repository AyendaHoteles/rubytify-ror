namespace :db do
  namespace :seed do
    task :spotify => [:environment] do
      spotify_service = SpotifyService.new()
      spotify_service.update_token()

      seed_file = Rails.root.join("app", "assets", "content", "artists.yml")
      config = YAML::load_file(seed_file)
      artists = config["artists"]
      artists.each do |artist_name|
          puts "Getting info for #{artist_name}"
          artist = spotify_service.get_artist(artist_name)
          if artist
            albums = spotify_service.get_albums(artist["id"])
            if albums
              puts "#{albums.length} albums retrieved"
              
              albums.each do |album|
                songs = spotify_service.get_songs(album["id"])
                if songs
                  puts "#{songs.length} songs retrieved for #{album["name"]}"
                end
              end
            end
          end
      end
    end
  end
end