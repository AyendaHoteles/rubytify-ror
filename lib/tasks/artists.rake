namespace :db do
    namespace :seed do
        desc "Seed Users from /db/seeds/artists.yml"
        task :artists => :environment do
            require "yaml"

            artists = YAML.load(File.read("db/seeds/artists.yml"))
            artists_lists = []
            artists["artists"].each do |artist|
                artists_lists += RSpotify::Artist.search(artist.to_s, limit: 1)
            end
            save_artists(artists_lists)
        end
    end
end

def save_artists(artists_lists)
    artists_lists.each do |artist_spo|
    artist = Artist.where(spotify_id: artist_spo.id).take
    if artist
        next
    else  
        artist = Artist.create!(
            :name => artist_spo.name,
            :image => artist_spo.images[0]["url"],
            :genres => artist_spo.genres,
            :popularity => artist_spo.popularity,
            :spotify_url => artist_spo.external_urls["spotify"],
            :spotify_id => artist_spo.id,
        )
    end
  end
end