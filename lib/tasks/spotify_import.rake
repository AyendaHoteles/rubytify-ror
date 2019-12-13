namespace :spotify_import do
  task create: :environment do

    #Clean Database
    Song.destroy_all
    Album.destroy_all
    Artist.destroy_all

    importMain = ImportMain.new(RspotifyService.new, ImportArtistsYaml.new)
    importMain.spotify_import
  end
end
