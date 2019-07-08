# frozen_string_literal: true

namespace :import do
  desc 'Import Shopify artists, albums and songs'
  task :spotify, [:path] => :environment do |_t, args|
    puts "Import - Shopify: Started at #{Time.current}"

    args.with_defaults(path: 'config/artists.yml')
    artists_names = YAML.load_file(args[:path])['artists'].map(&:to_s)

    Spotify::Importer.call(artists_names)

    puts "Import - Shopify: Finished at #{Time.current}"
  end
end
