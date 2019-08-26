require 'yaml'

namespace :artists do
  desc "import artists from artists.yml"
  task :populate => :environment do
    artists = YAML.load(
      File.read(
          File.expand_path('../artists.yml', __FILE__)
        )
      )["artists"]

    artists.each do |name|
      Artist.create!(name: name)
    end
  end
end