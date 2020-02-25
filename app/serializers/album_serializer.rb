# frozen_string_literal: true

class AlbumSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :image
  attribute :spotify_url
  attribute :total_tracks
end
