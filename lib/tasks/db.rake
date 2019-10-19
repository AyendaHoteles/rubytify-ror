# Rakefile
# frozen_string_literal: true

require 'rspotify'

namespace :db do
  namespace :seed do
    desc "Load artists from Spotify API"

    task :load_artists => :environment do
      artist_names = YAML.load_file("#{Rails.root.to_s}/lib/tasks/artists.yml")
      puts artist_names
    end
  end
end