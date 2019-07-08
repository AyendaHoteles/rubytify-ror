namespace :import do

  desc "Import Artists from yaml"

  task artists: :environment do
    @artists ||= YAML.load(File.read(File.expand_path("../../../lib/data/artists.yaml", __FILE__)))
    @artists.each do |artist|
      Artist.create(name: artist)
    end
  end
end