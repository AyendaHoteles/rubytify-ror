class SongSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :spotify_url, :preview_url, :duration_ms, :explicit
end
