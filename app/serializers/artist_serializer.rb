class ArtistSerializer < BaseSerializer
  attributes :id, :name, :image, :genres, :popularity, :spotify_url

  def genres
    object.genres.map {|genre| genre.name}
  end
end
