# frozen_string_literal: true

module Spotify
  class StoreDataArtist < Spotify::ResourcesData
    def search_artists
      spotify_artists.each do |artist|
        records = RSpotify::Artist.search(artist)
        next if records.blank?

        build_artist(records.first)
      end
    end

    private

    def build_artist(record)
      Artist.create_with(artist_params(record))
            .find_or_create_by(spotify_id: record.id)
    rescue StandardError
      raise RecordParamsError, record
    end

    def artist_params(record)
      {
        name: record.name,
        genres: record.genres,
        popularity: record.popularity,
        image: first_image(record),
        spotify_url: record.href
      }
    end
  end
end
