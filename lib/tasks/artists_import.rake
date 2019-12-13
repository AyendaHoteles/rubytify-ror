namespace :artists_import do
  task create: :environment do

    #Clean Database
    Song.destroy_all
    Album.destroy_all
    Artist.destroy_all
  end
end
