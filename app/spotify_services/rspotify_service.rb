
require "rspotify"

class RspotifyService
  def request_api(artists)
    RSpotify.authenticate(ENV["spotiy_client_id"], ENV["spotiy_client_secret"])

    artists_total = []
    artists.each do |name_artist|
      artist = RSpotify::Artist.search(name_artist.to_s, limit: 1)
      if !artist.last.nil?
        artists_total << artist.last
      else
        puts "#{name_artist} no exist in Spotify "
      end
    end

    artists_total.each do |artist|
      create_artist(artist)
    end
  end

  def create_artist(artist)
    puts "- Creating Artist " + artist.name
    artist_new = Artist.new(name: artist.name,
                            image: artist.images.last["url"],
                            genres: artist.genres,
                            popularity: artist.popularity,
                            spotify_url: artist.external_urls["spotify"],
                            spotify_id: spotify_id = artist.id)

    create_albums(artist.albums, artist_new) if artist_new.save
  end

  def create_albums(albums, artist)
    albums.each do |album|
      begin
        puts "- Creating Album " + artist.name
        album_new = Album.new(name: album.name,
                              image: album.images.last["url"],
                              spotify_url: album.external_urls["spotify"],
                              total_tracks: album.total_tracks,
                              spotify_id: album.id,
                              artist: artist)
        create_songs(album, album_new) if album_new.save
      rescue Errno::ETIMEDOUT => e
        puts "TIMEOUT retying."
        retry
      end
    end
  end

  def create_songs(album, album_new)
    album.tracks.each do |song|
      begin
        puts song.preview_url

        puts "- Creating Song " + song.name
        song_new = Song.create(name: song.name,
                               spotify_url: song.external_urls["spotify"],
                               preview_url: "song.preview_url.to_s",
                               duration_ms: song.duration_ms,
                               explicit: song.explicit,
                               spotify_id: song.id,
                               album: album_new)

        song_new.save
      rescue RestClient::TooManyRequests => e
        sleep e.response.headers[:retry_after].to_i
      end
    end
  end
end
