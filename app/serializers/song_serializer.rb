class SongSerializer < ActiveModel::Serializer
  attributes  :name, :preview_url, :duration_ms, :explicit, :spotify_url
end
