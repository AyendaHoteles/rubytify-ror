namespace :import do

  desc "Import Artists from yaml"

  task artists: :environment do
    artist_names ||= YAML.load(File.read(File.expand_path("../../../lib/data/artists.yaml", __FILE__)))
    ImportArtistsTaskJob.perform_later(artist_names)
    put "La tarea fue encolada y se ejecutará en background"
  end
end