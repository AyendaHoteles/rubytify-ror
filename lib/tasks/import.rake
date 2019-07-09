namespace :import do

  desc "Import Artists from yaml"

  task artists: :environment do
    artist_names ||= YAML.load(File.read(File.expand_path("../../../lib/data/artists.yaml", __FILE__)))
    artist_names.each do |artist|
      Artist.create(name: artist)
    end
    artists = Artist.all
    service = SpotifyService.new
    service.update_artists(artists)
  end
end