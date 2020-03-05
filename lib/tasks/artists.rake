namespace :artists do
  desc "Create artists from .yml file and import data from spotify"
  task import: :environment do
    path = Rails.root.join('db','artists.yml')
    puts "Importing artists from #{path}"
    data = YAML.load(File.read(path))
    data['artists'].each do |artist_name|
      Artist.create_from_spotify(artist_name)
    end
  end
end
