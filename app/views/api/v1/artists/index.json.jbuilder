json.data do
  json.array! @artists do |artist|
    json.extract! artist, :id, :spotify_id, :name, :image
    json.genres artist.genres
    json.extract! artist, :popularity, :spotify_url
  end
end
