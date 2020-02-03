namespace :importer do
  desc "Fetching data from Spotify Api"
  task :import_by_artist => [ :environment ] do
    start = DateTime.now
    p "Import rake started at #{start}"
    SpotifyImporter.new.import_artists
    p "Import finished successfully at #{DateTime.now}"
    p "Time Spent: #{(DateTime.now.to_f - start.to_f).to_i} seconds"
  end
end
