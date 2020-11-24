class ArtistSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image, :genres, :popularity, :spotify_url

  #has_many :albums
end
