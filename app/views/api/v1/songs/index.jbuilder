json.data @data do |song|
  json.name song.name
  json.spotify_url song.spotify_url
  json.preview_url song.preview_url
  json.duration_ms song.duration_ms
  json.explicit song.explicit
end