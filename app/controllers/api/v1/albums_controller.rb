class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :songs]

  def index
    render json: {data: Album.all.collect(&:details) }, status: :ok
  end

  def show
    render json: { data: @album.details }, status: :ok
  end

  def songs
    render json: { data: @album.songs.collect(&:details) }, status: :ok
  end

  private
    def set_album
      if !@album = Album.find_by(id: params[:id])
        render json: {message: "Product not found or disabled"}, status: :not_found
      end
    end
end
