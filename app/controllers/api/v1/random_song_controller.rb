class Api::V1::RandomSongController < ApplicationController
  before_action :get_genre, only: [:show_song]
  before_action :get_song, only: [:show_song]

  def show_song
    render json: @song, root: 'data', adapter: :json
  end

  private

  def get_genre
    @genre = params[:genre_name]
  end

  def get_song
    artist =  Artist.where("'#{@genre}' = ANY(genres)").order("RANDOM()").take
    album = artist.albums.order("RANDOM()").take
    @song = album.songs.order("RANDOM()").take
  end
end
