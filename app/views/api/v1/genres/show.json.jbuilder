json.data do
  json.extract! @genre, :name
  json.total_tracks @total_tracks
end
