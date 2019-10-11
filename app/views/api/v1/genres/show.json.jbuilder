json.data do
  json.genre @genre
  json.artists @artists do |artist|
    json.name artist
  end
end
