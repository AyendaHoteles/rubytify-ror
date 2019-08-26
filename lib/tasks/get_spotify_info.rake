namespace :db do
  namespace :seed do
    task :spotify => [:environment] do
      clean
      
      spotify_service = SpotifyService.instance
      spotify_service.update_token()

      artists = load_artists
      artists.each do |artist_name|
          puts "Getting info for #{artist_name}"
          artist = spotify_service.get_artist(artist_name)
          save_artist_info(artist)
      end
    end
  end
end


def clean
  puts 'Cleaning previous registers'
  Artist.delete_all
  Album.delete_all
  Song.delete_all
end


def load_artists
  seed_file = Rails.root.join("app", "assets", "content", "artists.yml")
  config = YAML::load_file(seed_file)
  artists = config["artists"]
  artists
end


def save_artist_info(artist)
  if artist
    artist_instance = Artist.create(Artist.map_to_schema(artist))
    artist_instance.save
    get_artist_albums(artist["id"])
  end
end


def get_artist_albums(artist_id)
  spotify_service = SpotifyService.instance
  albums = spotify_service.get_albums(artist_id)
  if albums
    puts "#{albums.length} albums retrieved"
    
    albums.each do |album|
      album["artist_id"] = artist_id
      save_album_info(album)
    end
  end
end


def save_album_info(album)
  album_instance = Album.create(Album.map_to_schema(album))
  album_instance.save
  get_album_songs(album["id"])
end


def get_album_songs(album_id)
  spotify_service = SpotifyService.instance
  songs = spotify_service.get_songs(album_id)
  if songs
    puts "#{songs.length} songs retrieved for album_id: #{album_id}"
    songs.each do |song|
      song["album_id"] = album_id
      begin
        song_instance = Song.create(Song.map_to_schema(song))
        song_instance.save
      rescue StandardError => e  
        puts e.message  
        puts e.backtrace.inspect  
      end 
    end
  end
end