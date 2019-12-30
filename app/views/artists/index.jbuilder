json.data @data do |artist|
  json.name artist.name
  json.spotify_url artist.spotify_url
  json.genres artist.genres
  json.popularity artist.popularity
end