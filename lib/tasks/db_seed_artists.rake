require "yaml"

# rake db:seed:artists
namespace :db do
  namespace :seed do
    desc "Seed Users from /db/seeds/artists.yml"
    task :artists => :environment do

      # Load hash from yaml file. key is artists and value is
      # artists array
      artists = YAML.load(File.read("db/seeds/artists.yml"))
      spotify_data_artists = []
      artists["artists"].each do |artist|

        # even that almost every single item in list is considered as string
        # there is an album that is being taken as an integer so we need to call
        # to.s method to make sure all are threated as strings
        spotify_data_artists += RSpotify::Artist.search(artist.to_s, limit: 1)
      end
      db_seed_artists(spotify_data_artists)
    end
  end
end

def db_seed_artists(spotify_data_artists)
  spotify_data_artists.each do |spotify_artist|
    # checks the artist already exists on the database
    artist = Artist.where(spotify_id: spotify_artist.id).take
    if artist
      db_seed_albums(artist, spotify_artist)
      next
    else
      begin
        artist = Artist.create!(
          :name => spotify_artist.name,
          :image => spotify_artist.images[0]["url"],
          :genres => spotify_artist.genres,
          :popularity => spotify_artist.popularity,
          :spotify_url => spotify_artist.external_urls["spotify"],
          :spotify_id => spotify_artist.id,
        )
        db_seed_albums(artist, spotify_artist)
      rescue => e
        puts e
      end
    end
  end
end

def db_seed_albums(artist, spotify_artist)
  # call albums method from spotify artist object to get albums
  albums = spotify_artist.albums
  albums.each do |spotify_album|
    # check if album exists
    album = Album.where(spotify_id: spotify_album.id).take
    if album
      db_seed_songs(album, spotify_album)
      next
    else
      begin
        album = Album.create!(
          :name => spotify_album.name,
          :image => spotify_album.images[0]["url"],
          :total_tracks => spotify_album.total_tracks,
          :spotify_url => spotify_album.external_urls["spotify"],
          :spotify_id => spotify_album.id,
          :artist_id => artist.id,
        )
        db_seed_songs(album, spotify_album)
      rescue => e
        puts e
      end
    end
  end
end

def db_seed_songs(album, spotify_album)
  # call tracks method from spotify album object to get tracks
  songs = spotify_album.tracks
  songs.each do |spotify_song|
    # check if song exists on db
    song = Song.where(spotify_id: spotify_song.id).take
    if song
      next
    else
      begin
        Song.create!(
          :name => spotify_song.name,
          :explicit => spotify_song.explicit,
          :duration_ms => spotify_song.duration_ms,
          :preview_url => spotify_song.preview_url,
          :spotify_url => spotify_song.external_urls["spotify"],
          :spotify_id => spotify_song.id,
          :album_id => album.id,
        )
      rescue => e
        puts e
      end
    end
  end
end
