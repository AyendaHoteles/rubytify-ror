class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :popularity, :spotify_url
  has_many :genres do
    object.genres.pluck(:name)
  end
end
