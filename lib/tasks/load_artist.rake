namespace :db do
  task :artists => :environment do
    client = ArtistClient.new
    client.fetch
  end
end