require 'yaml'

# rake db:seed:artists
  namespace :db do
    namespace :seed do
      desc "Seed Users from /db/seeds/artists.yml"
      task :artists => :environment do

        # Load hash from yaml file. key is artists and value is
        # artists array
        artists = YAML.load(File.read('db/seeds/artists.yml'))
        spotify_data_artists = []
        artists["artists"].each do |artist|

          # even that almost every single item in list is considered as string
          # there is an album that is being taken as an integer so we need to call
          # to.s method to make sure all are threated as strings
          spotify_data_artists += RSpotify::Artist.search(artist.to_s, limit: 1)
        end
        db_seed_artists(spotify_data_artists)
      end
    end
  end

  def db_seed_artists(spotify_data_artists)
    
    spotify_data_artists.each do |artist_data|
      # checks if the artist already exists on the database
      artist = Artist.where(spotify_id: artist_data.id).take
      if artist
        next
      else
        begin
          Artist.create!(
            :name => artist_data.name,
            :image => artist_data.images[0]['url'],
            :genres => artist_data.genres,
            :popularity => artist_data.popularity,
            :spotify_url => artist_data.external_urls['spotify'],
            :spotify_id => artist_data.id
          )
        rescue
          puts artist_data
        end
      end
    end
  end