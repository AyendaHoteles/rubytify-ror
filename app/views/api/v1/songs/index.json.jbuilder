json.data do
  json.array! @songs do |song|
    json.extract! song, :name, :spotify_url, :preview_url, :duration_ms, :explicit
  end
end
