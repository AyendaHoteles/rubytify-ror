# frozen_string_literal: true

class SpotifyDataArtistJob < ActiveJob::Base
  queue_as :spotify_data_artist

  def perform(*args)
    store_data_artist = Spotify::StoreDataArtist.new
    store_data_artist.search_artists
  end
end
