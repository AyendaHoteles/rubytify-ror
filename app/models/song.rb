class Song < ApplicationRecord
    validates :name, :spotify_url, :preview_url, :duration_ms, :spotify_id, presence:true
    validates_inclusion_of :explicit, in: [true,false]
    belongs_to :album
end
