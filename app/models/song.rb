class Song < ApplicationRecord
  belongs_to :album

  def details
    {
      name: name, spotify_url: spotify_url, preview_url: preview_url, duration_ms: duration_ms, explicit: explicit
    }
  end
end
