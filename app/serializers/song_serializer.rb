class SongSerializer < ActiveModel::Serializer

  attribute :name
  attribute :spotify_url
  attribute :preview_url
  attribute :duration_ms
  attribute :explicit

end
