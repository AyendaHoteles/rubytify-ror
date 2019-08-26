namespace :db do
  namespace :seed do
    task :spotify => [:environment] do
      Artist.delete_all
      Album.delete_all
      Song.delete_all

      spotify_service = SpotifyService.new()
      spotify_service.update_token()

      seed_file = Rails.root.join("app", "assets", "content", "artists.yml")
      config = YAML::load_file(seed_file)
      artists = config["artists"]
      artists.each do |artist_name|
          puts "Getting info for #{artist_name}"
          artist = spotify_service.get_artist(artist_name)
          if artist
            artist_instance = Artist.create(Artist.map_to_schema(artist))
            artist_instance.save

            albums = spotify_service.get_albums(artist["id"])
            if albums
              puts "#{albums.length} albums retrieved"
              
              albums.each do |album|
                album_instance = Album.create(Album.map_to_schema(album))
                album_instance.save

                songs = spotify_service.get_songs(album["id"])
                if songs
                  puts "#{songs.length} songs retrieved for #{album["name"]}"
                  
                  songs.each do |song|
                    song_instance = Song.create(Song.map_to_schema(song))
                    song_instance.save
                  end
                end
              end
            end
          end
      end
    end
  end
end