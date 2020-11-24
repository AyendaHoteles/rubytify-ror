class AlbumSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image, :spotify_url, :total_tracks

  #has_many :songs
end
