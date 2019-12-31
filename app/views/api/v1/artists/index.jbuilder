json.data @data do |artist|
  json.id artist.id
  json.name artist.name
  json.image artist.image
  json.genres artist.genres
  json.popularity artist.popularity
  json.spotify_url artist.spotify_url
end