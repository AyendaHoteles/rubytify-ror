# frozen_string_literal: true

class ArtistSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :image
  attribute :genres
  attribute :popularity
  attribute :spotify_url
end
