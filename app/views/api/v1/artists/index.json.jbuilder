json.data do
  json.array! @artists do |artist|
    json.extract! artist, :id, :name, :image, :genres, :popularity, :spotify_url
  end
end
