class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :genres, :popularity, :spotify_url, :spotify_id, :image
end
