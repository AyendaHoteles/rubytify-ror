class Api::V1::ArtistsController < ApplicationController
    def index
        artists = Artist.select(:id, :name, :image, :genres, :popularity, :spotify_url)
                        .order(popularity: :desc)
        json_artists = []
        artists.each do |artist|
            json_artist = artist.as_json(except: :genres)
            json_artist['genres'] = artist.genres.split('|').as_json
            json_artists.push(json_artist)
        end
        render json: {data: json_artists}, status: :ok
    end
end
