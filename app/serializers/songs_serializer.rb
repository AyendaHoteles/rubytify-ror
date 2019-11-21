class SongsSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_url, :preview_url, :duration_ms, :explicit

  def root
    "data"
  end

  def id
    @object.spotify_id
  end
end
