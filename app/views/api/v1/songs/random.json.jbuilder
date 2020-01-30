json.data do
  json.extract! @song, :name, :spotify_url, :preview_url, :duration_ms, :explicit
end
