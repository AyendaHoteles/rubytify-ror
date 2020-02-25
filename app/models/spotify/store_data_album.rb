# frozen_string_literal: true

module Spotify
  class StoreDataAlbum < Spotify::ResourcesData
    def search_albums
      Artist.all.each do |artist|
        record = RSpotify::Artist.find(artist.spotify_id)
        next if record.blank?

        create_albums(artist, record)
      end
    end

    private

    def create_albums(artist, record)
      record.albums.each do |album|
        build_album(artist, album)
      end
    end

    def build_album(artist, record)
      artist.albums.create_with(album_params(record))
            .find_or_create_by(spotify_id: record.id)
    # rescue StandardError
    #   raise RecordParamsError, record
    end

    def album_params(record)
      {
        name: record.name,
        image: first_image(record),
        total_tracks: record.total_tracks,
        spotify_url: record.href
      }
    end
  end
end
