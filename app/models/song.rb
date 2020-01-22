class Song < ApplicationRecord
    validates :name, :spotify_url, :preview_url, :spotify_id, presence: true
    validates :duration_ms, numericality: true
    validates :explicit, inclusion: { in: [true, false] }
end
