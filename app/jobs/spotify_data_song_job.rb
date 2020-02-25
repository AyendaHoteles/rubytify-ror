# frozen_string_literal: true

class SpotifyDataSongJob < ActiveJob::Base
  queue_as :spotify_data_song

  def perform(*args)
    store_data_song = Spotify::StoreDataSong.new
    store_data_song.search_songs
  end
end
