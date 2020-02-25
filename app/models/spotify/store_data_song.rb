# frozen_string_literal: true

module Spotify
  class StoreDataSong
    def search_songs
      Album.all.each do |album|
        record = RSpotify::Album.find(album.spotify_id)
        next if record.blank?

        create_songs(album, record)
      end
    end

    private

    def create_songs(album, record)
      record.tracks.each do |song|
        build_song(album, song)
      end
    end

    def build_song(album, record)
      album.songs.create_with(song_params(record))
           .find_or_create_by(spotify_id: record.id)
    rescue StandardError
      raise RecordParamsError, record
    end

    def song_params(record)
      {
        name: record.name,
        explicit: record.explicit,
        preview_url: record.preview_url,
        duration_ms: record.duration_ms,
        spotify_url: record.href
      }
    end
  end
end
