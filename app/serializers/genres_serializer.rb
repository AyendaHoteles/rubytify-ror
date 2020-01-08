class GenresSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :preview_url, :duration_ms, :explicit
end
