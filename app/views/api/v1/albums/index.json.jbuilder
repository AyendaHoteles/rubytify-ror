json.data do
  json.array! @albums do |album|
    json.extract! album, :id, :name, :image, :spotify_url, :total_tracks
  end
end
