json.data do
  json.array! @albums do |album|
    json.extract! album, :spotify_id, :name, :image, :spotify_url, :total_tracks, :id
  end
end
