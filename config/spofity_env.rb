spotify_config = File.expand_path('../spotify_key.yml', __FILE__)

if File.exists?(spotify_config)
  config = YAML.load_file(spotify_config)
  config.fetch(Rails.env, {}).each do |key, value|
    ENV[key.upcase] = value.to_s
  end
end
