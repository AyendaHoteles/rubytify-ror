namespace :db do
  task :albums => :environment do
    client = AlbumClient.new
    client.fetch
  end
end