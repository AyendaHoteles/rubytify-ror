class SongSerializer < ActiveModel::Serializer
  attributes :duration_ms, :explicit, :name, :spotify_url, :preview_url
end
