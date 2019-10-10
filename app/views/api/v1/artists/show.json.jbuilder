json.data do
  json.extract! @artist, :spotify_id, :name, :image, :popularity, :spotify_url, :id
  json.albums @artist.albums do |album|
    json.extract! album, :id, :name, :spotify_url
  end
end
