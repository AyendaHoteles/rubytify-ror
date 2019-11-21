class AlbumsSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url, :total_tracks

  def root
    "data"
  end

  def id
    @object.spotify_id
  end
end
