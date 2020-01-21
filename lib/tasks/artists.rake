namespace :custom do
    desc "import the specified artist"
  
    task :do_it do
        require "yaml"

        file = YAML.load(File.read("db/seeds/artists.yml"))
        file["artists"].each do |artist|
            artist.to_s
        end
    end
end