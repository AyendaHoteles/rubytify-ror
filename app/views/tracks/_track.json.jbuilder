json.extract! track, :id, :name, :preview_url, :duration_ms, :spotify_url, :spotify_id, :spotify_id_album, :explicit, :genres, :created_at, :updated_at
json.url track_url(track, format: :json)
