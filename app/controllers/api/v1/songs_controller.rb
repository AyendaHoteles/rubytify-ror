class Api::V1::SongsController < ApplicationController
  before_action :set_genre, only: :random

  # GET /artists/:id/songs
  def random
    @song = Song.find_by_sql("
      SELECT songs.id, songs.name, songs.spotify_url, songs.preview_url, songs.duration_ms, songs.explicit
      FROM songs
      INNER JOIN albums ON songs.album_id = albums.id
      INNER JOIN artists ON albums.artist_id = artists.id
      WHERE artists.genres LIKE '%#{@genre.downcase}%'").sample(1)
    json_response(@song)
  end  

  private

  def set_genre
    @genre = params[:genre_name]
    bad_chars = [ '/', '\\', '?', '%', '*', ':', '|', '"', '<', '>', '.', ' ' ]
    bad_chars.each do |bad_char|
      @genre.gsub!(bad_char, '_')
    end      
  end     
end
