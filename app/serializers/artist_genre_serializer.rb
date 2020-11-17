class ArtistGenreSerializer < ActiveModel::Serializer
  attributes :id
  has_one :artist
  has_one :genre
end
