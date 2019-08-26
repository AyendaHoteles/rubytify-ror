class Album < ApplicationRecord
    @valid_fields = [
        "name",
        "image",
        "total_tracks",
        "spotify_url",
        "spotify_id"
    ]

    def self.map_to_schema(entity)
        if entity["images"].length > 1
            entity["image"] = entity["images"][0]["url"]
        end
        Base.map_to_schema(entity, @valid_fields)
    end
end
