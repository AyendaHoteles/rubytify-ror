class ArtistSerializer < ActiveModel::Serializer

  attribute :id
  attribute :name
  attribute :image
  attribute :genres
  attribute :popularity
  attribute :spotify_url

  def genres
    object.genres.pluck(:name)
  end

end
