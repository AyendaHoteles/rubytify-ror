# rake db:seed:artists
  namespace :db do
    namespace :seed do
      desc "Seed Users from /db/seeds/artists.yml"
      task :artists => :environment do
        @yaml_data = YAML.load_file('../../db/seeds/artists.yml')
      end
    end
  end