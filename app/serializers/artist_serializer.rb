class ArtistSerializer < ActiveModel::Serializer
  attributes :genres, :id, :image, :name, :popularity, :spotify_url
end
