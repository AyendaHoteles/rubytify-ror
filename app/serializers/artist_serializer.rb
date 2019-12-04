class ArtistSerializer < ActiveModel::Serializer
  attributes  :name, :image, :genres, :popularity, :spotify_url, :spotify_id
end
