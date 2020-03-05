module Services::Spotify
  class Artist < Services::Spotify::Base
    class << self
      def create(name)
        artist_data = Services::Spotify::Search.show(name, "artist")
        if artist_data.present?
          artist = ::Artist.where(spotify_id: artist_data['id']).first_or_initialize.tap do |art|
            art.name        = artist_data["name"]
            art.image       = artist_data['images'].collect{|img| img['url']}.first
            art.genres      = artist_data["genres"]
            art.popularity  = artist_data['popularity']
            art.spotify_url = artist_data['external_urls']['spotify']
          end
          create_albums(artist)
          create_songs(artist)
          artist.save
        end
      end

      def create_albums(artist)
        albums_from_artist = Services::Spotify::Album.all(artist.spotify_id)
        albums_from_artist.each do |album_data|
          artist.albums.where(spotify_id: album_data['id']).first_or_initialize.tap do |alb|
            alb.name         = album_data['name']
            alb.image        = album_data['images'].collect{|img| img['url']}.first
            alb.spotify_url  = album_data['external_urls']['spotify']
            alb.total_tracks = album_data['total_tracks']
          end
        end
      end

      def create_songs(artist)
        artist.albums.each do |album|
          songs_from_album = Services::Spotify::Track.all(album.spotify_id)
          songs_from_album.each do |song_data|
            album.songs.where(spotify_id: song_data['id']).first_or_initialize.tap do |track|
              track.name         = song_data['name']
              track.spotify_url  = song_data['external_urls']['spotify']
              track.preview_url  = song_data['preview_url']
              track.duration_ms  = song_data['duration_ms']
              track.explicit     = song_data['explicit']
            end
          end
        end
      end
    end
  end
end
