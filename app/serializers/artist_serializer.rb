class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :popularity, :spotify_url, :genres

  def genres
    object.artist_genres.map{ |genre| genre.genre.name }
  end
end
