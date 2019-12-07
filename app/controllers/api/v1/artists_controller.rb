class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /artists
  def index
    artists = Artist.all.order(popularity: :desc)
    data = {data: artists.map { |e| ArtistSerializer.new(e) }}
    render json: data
  end

  # GET /artists/id/albums
  def albums
    albums = Artist.find_by(params[:id]).albums
    data = {data: albums.map { |e| AlbumSerializer.new(e) }}
    render json: data
  end

  # GET /artists/1
  def show
    render json: @artist
  end

  # POST /artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  def destroy
    @artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.require(:artist).permit(:name, :image, :genres, :popularity, :spotify_url, :spotify_id)
    end
end
