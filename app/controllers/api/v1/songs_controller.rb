class Api::V1::SongsController < ApplicationController
  def random_song
      artists = Artist.select { |artist| artist.genres.include?(params[:genre_name]) }
      song = artists.sample.songs.sample
      render_resources(song, %i[name spotify_url preview_url duration_ms explicit])
  end
end
