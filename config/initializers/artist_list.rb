module ArtistList
  file = YAML.load_file(File.join(Rails.root,'config', 'artistlist.yml'))
end