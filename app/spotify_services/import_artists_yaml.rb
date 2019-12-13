class ImportArtistsYaml
  #Import artists from a yaml file
  def get_artists
    artists = YAML.load_file(Rails.root.join("db", "seeds", "artists.yml")).values[0]
  end
end
