# Define a namespace for the task
namespace :db do
  namespace :seed do
    # Description for the task
    desc "Import Data from YML file with list of artits"
    # Define the task
    task :artists => :environment do
      # Your task goes here
      db_seed_artists
    end
  end
end

#seed multiple artists by loading yml file
def db_seed_artists
  path = Rails.root.join('db','seeds','artists.yml')
  puts "Seeding file #{path}"
  loaded_artists = YAML.load_file(File.open(path, "r"))
  #puts loaded_artists.to_json
  loaded_artists.values[0].each  do |doc|
    #puts doc.to_s
    #l_search = RSpotify::Artist.search(doc.to_s).total 
    unless RSpotify::Artist.search(doc.to_s).total == 0
      artist_record = RSpotify::Artist.search(doc.to_s)
      #puts artist_record.first
      unless Artist.where(:spotify_id => artist_record.first.id).count > 0
        create_single_artist(artist_record.first)
        albums = artist_record.first.albums
        albums.each do |spotify_album|
          create_single_album(spotify_album, artist_record.first)
          track_list = spotify_album.tracks
          track_list.each do |spotify_song|
            create_single_song(spotify_song, spotify_album, artist_record.first)
          end
        end
      end
    end
  end
end
  
  def create_single_artist(spotify_artist)
    Artist.create(spotify_id: spotify_artist.id) do |reg|
      reg.name        = spotify_artist.name
      reg.image       = spotify_artist.images.first["url"]
      reg.genres      = spotify_artist.genres
      reg.popularity  = spotify_artist.popularity
      reg.spotify_url = spotify_artist.external_urls.first[1]
    end
  end
  
  def create_single_album(spotify_album, spotify_artist)
    Album.create(spotify_id: spotify_album.id) do |reg|
      reg.name         = spotify_album.name
      reg.image        = spotify_album.images.first["url"]
      reg.spotify_url  = spotify_album.external_urls.first[1]
      reg.total_tracks = spotify_album.total_tracks
      reg.artist_id    = spotify_artist.id
      reg.genres       = spotify_artist.genres
    end
  end
    
  def create_single_song(spotify_song, spotify_album, spotify_artist)
    Song.create(spotify_id: spotify_song.id) do |reg|
      reg.name         = spotify_song.name
      reg.spotify_url  = spotify_song.external_urls.first[1]
      reg.preview_url  = spotify_song.preview_url
      reg.duration_ms  = spotify_song.duration_ms
      reg.explicit     = spotify_song.explicit
      reg.album_id     = spotify_album.id
      reg.genres       = spotify_artist.genres
      
    end
  end