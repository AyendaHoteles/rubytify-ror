namespace :importer do
  desc "Fetching data from Spotify Api"
  task :import_by_artist => [ :environment ] do
    SpotifyImporter.new.import_artists
  end
end
