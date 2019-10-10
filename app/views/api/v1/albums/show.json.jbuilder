json.data do
  json.extract! @album, :name, :image, :spotify_url, :total_tracks, :id
end
