class Song < ApplicationRecord
    belongs_to :album, optional: true
    
    validates :name, :spotify_url, :spotify_id, presence: true
    validates :duration_ms, numericality: true
    validates :explicit, inclusion: { in: [true, false] }    
end
