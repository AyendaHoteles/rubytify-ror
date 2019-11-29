class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options = {})
    super({:except => [:spotify_id, :artist_id, :album_id]}.merge(options))
  end
end
