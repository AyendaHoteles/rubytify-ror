class Api::V1::GenresController < ApplicationController
  before_action :spotify_authenticate


  def random
    genre_seach = params['genre_name']
    artist = Artist.select {|artist| artist.genres.include?(genre_seach)}.shuffle.last.spotify_id
    artist = RSpotify::Artist.find(artist)
    random_song = artist.albums.shuffle.last.tracks.shuffle.last
    
    random_song = build_random_song_json(random_song)

    render json: random_song
  end

  private

  def spotify_authenticate
    RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])
  end

  def build_random_song_json(song)
    required_json = Hash.new { |h, k| h[k] = [] }

      required_json['data'] << {
        id: "#{song.id}", 
        name: "#{song.name}",
        spotify_url: "#{song.external_urls['spotify']}",
        preview_url: "#{song.preview_url}",
        duration_ms: "#{song.duration_ms}",
        explicit: "#{song.explicit}"
      }
    required_json

  end
end
