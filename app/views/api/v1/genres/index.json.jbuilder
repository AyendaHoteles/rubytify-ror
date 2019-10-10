json.data do
  json.array! @genres do |genre|
    json.extract! genre, :name, :id
  end
end
