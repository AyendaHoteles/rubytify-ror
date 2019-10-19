namespace :artists do
  desc 'Load Artists from Spotify'
  task load: :environment do
    Importer.start
  end
end
