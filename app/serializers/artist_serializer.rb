class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_id, :spotify_url, :popularity
  attribute :genres do
    JSON.parse(object.genres)
  end
end
