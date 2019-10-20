class ApplicationController < ActionController::API
    
    protected

    def serialize_artists(artists)
        artistas = []
        artists.map do |artist|
            artista = {}
            artista[:id] = artist.id
            artista[:name] = artist.name
            artista[:image] = artist.image
            artista[:genres] = artist.genres.pluck(:name)
            artista[:popularity] = artist.popularity
            artista[:spotify_url] = artist.spotify_url
            artistas << artista
        end
        return artistas
    end
end
