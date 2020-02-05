# frozen_string_literal: true

class RandomSongSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :preview_url, :duration_ms, :explicit
end
