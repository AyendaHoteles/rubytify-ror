namespace :import_from_spotify do
  desc 'Import all info for the artists listed on the yaml file'
  task artists: :environment do
    artists = YAML.load_file('data/yaml/artists.yml')['artists']
    artists.each do |artist|
      ArtistImportJob.perform_later(artist.to_s)
    end
  end

  desc 'Import all info on the albums of the artist stored in db'
  task albums: :environment do
    artists = Artist.all
    artists.each do |artist|
      AlbumImportJob.perform_later(artist.id)
    end
  end
end
