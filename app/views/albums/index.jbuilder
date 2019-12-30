json.data @data do |album|
  json.name album.name
  json.spotify_url album.spotify_url
  json.total_tracks album.total_tracks
end
