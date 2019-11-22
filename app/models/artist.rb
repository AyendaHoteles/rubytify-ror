class Artist < ApplicationRecord
    validates name, image,genres, popularity,spotify_url,spotify_id, presence:true
end
