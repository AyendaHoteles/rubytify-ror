class Api::V1::AlbumsController < ApplicationController

  def show
    render json: { data: find_songs }
  end

  private
    def find_songs
      songs_array = []
      songs = Song.where(album_id: params[:id])
      songs.each do |s|
        new_song = {name: s.name, spotify_url: s.spotify_url, preview_url: s.preview_url, duration_ms: s.duration_ms, explicit: s.explicit }
        songs_array.push(new_song)
      end
      songs_array
    end

end
