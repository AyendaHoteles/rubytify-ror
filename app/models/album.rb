class Album < ApplicationRecord
    validates name, image, spotify_url, total_track, spotify_id, presence: true
end
