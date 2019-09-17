class Api::V1::AlbumsController < ApplicationController

  def index
    get_albums
  end
  private

    def get_albums
      albums = Album.where(artist_id: params[:id])
      album_list = []
      albums.each do |a|
        new_object = { id: a.id, name: a.name, image: a.image, spotify_url: a.spotify_url, total_tracks: a.total_tracks }
        album_list << new_object
      end
      answer = { data: album_list }
      json_response(answer)
    end

end
