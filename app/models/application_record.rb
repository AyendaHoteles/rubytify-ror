class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options = {})
    super(:except => [:spotify_id, :artist_id, :id, :album_id] )
  end
end
