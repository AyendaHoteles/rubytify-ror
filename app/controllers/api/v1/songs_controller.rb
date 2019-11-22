class Api::V1::SongsController < ApplicationController
  before_action :get_tracks, only: [:random_song]

  # return a random song that matches genre
  def random_song
    render json: { data: @songs.sample }, except: [:id, :spotify_id, :updated_at, :created_at, :album_id]
  end

  private

  def get_tracks
    # get artists by genre_name. Call scope from Artist model
    artists = Artist.genre_filter(params[:genre_name])
    artists_ids = artists.map { |artist| artist.id }

    # get albums by artist.id. Call scope from Album model
    albums = Album.artists_filter(artists_ids)
    albums_ids = albums.map { |album| album.id }

    # get albums by Song.id. Call scope from Song model
    @songs = Song.album_filter(albums_ids)
  end
end
