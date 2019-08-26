class Song < ApplicationRecord
    @valid_fields = [
        "name",
        "spotify_url",
        "preview_url",
        "duration_ms",
        "explicit",
        "spotify_id",
        "album_id",
    ]

    def self.map_to_schema(entity)
        entity["spotify_id"] = entity["id"]
        entity["spotify_url"] = entity["external_urls"]["spotify"]
        Base.map_to_schema(entity, @valid_fields)
    end
end
