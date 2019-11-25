class Song < ApplicationRecord
    validates :name, :spotify_url, :preview_url, :duration_ms, :spotify_id, presence:true
    validates_inclusion_of :explicit, in: [true,false]
    belongs_to :album

    def self.random(genre)
      joins(album: :artist).where("artists.genres @> ?", "{#{genre}}").order(Arel.sql "RANDOM()").first
    end
end
