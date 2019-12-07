class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :genres, :popularity, :spotify_url

  def genres
  	object.genres.pluck(:name)
  end
end
