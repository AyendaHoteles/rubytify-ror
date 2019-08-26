class Api::V1::ArtistsController < ApplicationController
  before_action :spotify_authenticate

  def index
    artists = Artist.all.order(popularity: :desc)
    if artists.where(spotify_id: nil).present?
      build_artist_information(artists)
    end
    artists_json = build_artists_json(artists)
    render json: artists_json
  end

  private

  def spotify_authenticate
    RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])
  end

  def build_artist_information(artists)
    artists.where(spotify_id: nil).each do |artist|
      spot_artist = RSpotify::Artist.search(artist.name).first
      if spot_artist.present?
        artist.update(
          spotify_id: spot_artist.id,
          genres: spot_artist.genres,
          popularity: spot_artist.popularity,
          spotify_url: spot_artist.external_urls["spotify"],
          image: spot_artist.images.first)
      end
    end
  end

  def build_artists_json(artists)
    required_json = Hash.new { |h, k| h[k] = [] }

    artists.map do |artist|
      required_json['data'] << {
        id: "#{artist.id}", 
        name: "#{artist.name}", 
        popularity: "#{artist.popularity}", 
        genres: artist.genres, 
        spotify_url: "#{artist.spotify_url}",
        image: "#{artist.image}" }
    end
    required_json

  end
end
