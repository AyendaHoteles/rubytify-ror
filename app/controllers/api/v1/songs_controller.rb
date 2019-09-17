class Api::V1::SongsController < ApplicationController

  def index
    get_songs
  end

  private
    def get_songs
      songs = Song.where(album_id: params[:id])
      song_list = []
      songs.each do |s|
        new_object = { name: s.name, spotify_url: s.spotify_url, preview_url: s.preview_url, duration_ms: s.duration_ms, explicit: s.explicit }
        song_list << new_object
      end
      answer = { data: song_list }
      json_response(answer)
    end

end
