class SongSerializer < ActiveModel::Serializer
  attributes :id, :spotify_url, :preview_url, :duration_ms, :explicit

  def root
    'data'
  end
end
