class ArtistSerializer < ActiveModel::Serializer
  attributes :spotify_id, :name, :image, :genres, :popularity, :spotify_url
end
