class Song < ApplicationRecord
    @valid_fields = [
        "name",
        "spotify_url",
        "preview_url",
        "duration_ms",
        "explicit",
        "spotify_id"
    ]

    def self.map_to_schema(entity)
        Base.map_to_schema(entity, @valid_fields)
    end
end
