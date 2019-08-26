class Artist < ApplicationRecord
    @valid_fields = [
        "name",
        "image",
        "genres",
        "popularity",
        "spotify_url",
        "spotify_id",
    ]

    def genres=(val)
        write_attribute(:genres, val.join(", "))
    end

    def self.map_to_schema(entity)
        if entity["images"].length > 1
            entity["image"] = entity["images"][0]["url"]
        end
        entity["spotify_id"] = entity["id"]
        entity["spotify_url"] = entity["external_urls"]["spotify"]
        Base.map_to_schema(entity, @valid_fields)
    end
end
