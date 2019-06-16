class SongSerializer < BaseSerializer
  attributes(:preview_url, :duration_ms, :explicit)
end
