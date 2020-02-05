# frozen_string_literal: true

class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url, :total_tracks
end
