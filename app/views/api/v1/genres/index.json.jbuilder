json.data do
  json.array! @genres do |genre|
    json.genre genre
  end
end
