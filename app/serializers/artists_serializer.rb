class ArtistsSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :genres, :popularity, :spotify_url

  def root
    "data"
  end
end
