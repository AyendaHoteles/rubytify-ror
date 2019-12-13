namespace :spotify do
  desc 'Populate tables with data from Spotify'
  task populate: :environment do
    artists_file = 'lib/tasks/demo_data/artists.yml'
    abort("The file #{artists_file} was not found") unless File.exist?(artists_file)

    artists = YAML.load_file(artists_file)['artists']
    puts "populating data from #{artists.size} artists."
    populator = DemoData::Populator.new(artists)
    populator.process
    puts 'the process has completed.'
  end
end
