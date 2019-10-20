class Api::V1::AlbumsController < ApplicationController
  def songs
    album = Album.find(params[:id])
    songs = album.songs
    render_resources(songs, %i[name spotify_url preview_url duration_ms explicit])
  end
end
