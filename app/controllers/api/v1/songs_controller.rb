class Api::V1::SongsController < ApplicationController

  def index
    @album = Album.find(params['album_id'])
    if @album.songs.empty?
      RSpotify::Album.find(@album.spotify_id).tracks.each do |song|
        Song.create(name: song.name,
        spotify_id: song.id,
        spotify_url: song.external_urls['spotify'],
        preview_url: song.preview_url,
        duration_ms: song.duration_ms,
        explicit: song.explicit,
        album_id: @album.id)
      end
    end
    @songs = @album.songs
    @songs_json = build_songs_json(@songs)

    render json: @songs_json
    end

  def build_songs_json(songs)
    required_json = Hash.new { |h, k| h[k] = [] }

    songs.map do |song|
      required_json['data'] << {
        id: "#{song.id}", 
        name: "#{song.name}",
        spotify_url: "#{song.spotify_url}",
        preview_url: "#{song.preview_url}",
        duration_ms: "#{song.duration_ms}",
        explicit: "#{song.explicit}",
        album_id: "#{song.album_id}",
      }
    end
    required_json
  end
end
