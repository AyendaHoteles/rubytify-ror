# frozen_string_literal: true

class SongSerializer < ActiveModel::Serializer
  attribute :name
  attribute :duration_ms
  attribute :explicit
  attribute :preview_url
  attribute :spotify_url
end
