class Song < ApplicationRecord
  belongs_to :album

  def as_json(options = {})
    super(options.merge(:except => [:id,:album_id,:spotify_id]) )
  end
end
