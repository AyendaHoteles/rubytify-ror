class ArtistSerializer < ActiveModel::Serializer
  attributes :name, :image, :genres, :popularity, :spotify_url
end
