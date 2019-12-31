json.data @data do |album|
  json.id album.id
  json.name album.name
  json.image album.image
  json.spotify_url album.spotify_url
  json.total_tracks album.total_tracks
end
