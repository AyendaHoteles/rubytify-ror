# frozen_string_literal: true

class SpotifyDataAlbumJob < ActiveJob::Base
  queue_as :spotify_data_album

  def perform(*args)
    store_data_album = Spotify::StoreDataAlbum.new
    store_data_album.search_albums
  end
end
