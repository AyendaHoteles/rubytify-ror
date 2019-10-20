class SongSerializer < BaseSerializer
  attributes :id, :spotify_url, :preview_url, :duration_ms, :explicit
end
