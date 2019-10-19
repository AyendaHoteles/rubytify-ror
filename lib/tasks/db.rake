namespace :db do
  desc "Empty the db and populates with data from spotify API"
  task fetch_and_populate: :environment do
    # drop all databases
    Rake::Task['db:reset'].invoke

    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    artists_yaml = YAML.load(File.read("artists.yml"))

    artists_yaml["artists"].each do |artist|
      artists = RSpotify::Artist.search(artist.to_s)
      artist_fetched = artists.first
      # p artist_fetched
      #  name        :string
      #  image       :text
      #  popularity  :integer
      #  spotify_url :text
      #  spotify_id  :strin
      if artist_fetched
        artist = Artist.create({
          name: artist_fetched.name,
          image: artist_fetched.images[0]["url"],
          popularity: artist_fetched.popularity,
          spotify_url: artist_fetched.external_urls["spotify"],
          spotify_id: artist_fetched.id
        })
        artist.save!
      end

    end

  end
end
