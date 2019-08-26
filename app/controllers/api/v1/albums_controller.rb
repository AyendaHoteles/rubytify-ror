class Api::V1::AlbumsController < ApplicationController
  def index
  @artist = Artist.find(params['artist_id'])
  @spotify_artist = RSpotify::Artist.find(@artist.spotify_id)
  if @artist.albums.empty?
    @spotify_artist.albums.each do |album|
      Album.create(name: album.name,
      spotify_id: album.id,
      spotify_url: album.external_urls['spotify'],
      image: album.images.first,
      total_tracks: album.total_tracks,
      artist_id: @artist.id)
    end
  end

  @aalbums_json = build_albums_json(@artist.albums)

  render json: @aalbums_json
  end

  def build_albums_json(albums)
    required_json = Hash.new { |h, k| h[k] = [] }

    albums.map do |album|
      required_json['data'] << { 
      id: "#{album.id}", 
      name: "#{album.name}",
      image: "#{album.image}",
      spotify_url: "#{album.spotify_url}",
      total_tracks: "#{album.total_tracks}",

    }
    end

    required_json
  end
end