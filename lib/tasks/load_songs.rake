namespace :db do
  task :songs => :environment do
    client = SongClient.new
    client.fetch
  end
end
