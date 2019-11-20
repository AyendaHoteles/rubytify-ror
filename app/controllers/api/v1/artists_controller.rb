class Api::V1::ArtistsController < ApplicationController
    def index
        artists = Artist.select(:id, :name, :image, :genres, :popularity, :spotify_url)
                        .order(popularity: :desc)
        artists.each do |artist|
            artist.genres = artist.genres.split('|')
        end
        render json: {data: artists}, status: :ok
    end
end
