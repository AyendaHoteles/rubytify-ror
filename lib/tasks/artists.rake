namespace :db do
    namespace :seed do
        desc "Seed Users from /db/seeds/artists.yml"
        task :artists => :environment do
            require "yaml"

            artists = YAML.load(File.read("db/seeds/artists.yml"))
            artists_lists = []
            artists["artists"].each do |artist|
                artists_lists += RSpotify::Artist.search(artist.to_s, limit: 1)
            end
            set_artists(artists_lists)
        end
    end
end

def set_artists(artists_lists)
    artists_lists.each do |artist_spo|
    # Verify the artists existence
    artist = Artist.where(spotify_id: artist_spo.id).take
    if artist
        set_albums(artist, artist_spo)
        next
    else
        artist = Artist.create!(
            :name => artist_spo.name,
            :image => artist_spo.images[0]["url"],
            :genres => artist_spo.genres,
            :popularity => artist_spo.popularity,
            :spotify_url => artist_spo.external_urls["spotify"],
            :spotify_id => artist_spo.id,
        )
        set_albums(artist, artist_spo)
    end
  end
end

def set_albums(artist, artist_spo)
    albums = artist_spo.albums
    albums.each do |album_spo|
    # Verify the album existence
    album = Album.where(spotify_id: album_spo.id).take
    if album
        set_songs(album, album_spo)
        next
    else
        album = Album.create!(
            :name => album_spo.name,
            :image => album_spo.images[0]["url"],
            :total_tracks => album_spo.total_tracks,
            :spotify_url => album_spo.external_urls["spotify"],
            :spotify_id => album_spo.id,
            :artist_id => artist.id,
        )
        set_songs(album, album_spo)
    end
  end
end

def set_songs(album, album_spo)
    songs = album_spo.tracks
    songs.each do |song_spo|
    # check song exists on db
    song = Song.where(spotify_id: song_spo.id).take
    if song
        next
    else
        Song.create!(
            :name => song_spo.name,
            :explicit => song_spo.explicit,
            :duration_ms => song_spo.duration_ms,
            :preview_url => song_spo.preview_url,
            :spotify_url => song_spo.external_urls["spotify"],
            :spotify_id => song_spo.id,
            :album_id => album.id,
        )
    end
  end
end