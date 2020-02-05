# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :artist, only: :albums

  def songs
    songs = album.songs
    render(
      json: {
        data: songs.map { |song| SongSerializer.new(song) }
      }
    )
  end

  private

  def album
    Album.find(params[:id])
  end
end
