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
            save_artists(artists_lists)
        end
    end
end

def save_artists(artists_lists)
    artists_lists.each do |artist_spo|
        artist = Artist.where(spotify_id: artist_spo.id)
    if artist
        save_albums(artist, artist_spo)
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
        save_albums(artist, artist_spo)
    end
  end
end

def save_albums(artist, artist_spo)
    albums = artist_spo.albums
    albums.each do |album_spo|
        album = Album.where(spotify_id: album_spo.id)
    if album
        save_songs(album, album_spo)
        next
    else
        begin  
            album = Album.create!(
                :name => album_spo.name,
                :image => album_spo.images[0]["url"],
                :total_tracks => album_spo.total_tracks,
                :spotify_url => album_spo.external_urls["spotify"],
                :spotify_id => album_spo.id,
                :artist_id => artist.id,
            )
            save_songs(album, album_spo)
        rescue => e  
            puts e
        end
    end
  end
end

def save_songs(album, album_spo)
    songs = album_spo.tracks
    songs.each do |song_spo|
        song = Song.where(spotify_id: song_spo.id).take
    if song
        next
    else  
        begin
            Song.create!(
                :name => song_spo.name,
                :spotify_url => song_spo.external_urls["spotify"],
                :preview_url => song_spo.preview_url,
                :duration_ms => song_spo.duration_ms,
                :explicit => song_spo.explicit,
                :spotify_id => song_spo.id,
                :album_id => album.id,
            )
        rescue => e  
            puts e  
        end
    end
  end
end