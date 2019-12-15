namespace :spotify_import do
  task create: :environment do

    #Clean Database
    Song.destroy_all
    Album.destroy_all
    Artist.destroy_all

=begin
ImportMain is the main class is who have the responsabilty of get data of sportify and create in our database but it does not know how happed it, you should inject two dependencis firts is the service to get data from stotify,
and second dependency is to import names, you can create another implemantations of import from spotify like spotify-api or another implementation of import artist names like from excel or cvs etc.

In this example I create two classes that you can inject for get data 1. RspotifyRequest(it use rspotify gem)  2. HttpPartyService(it use httpparty gem)
for the import artist dependency I create two classes 1. ImportAritstYml  2. ImportArtistTxt

=end
    importMain = ImportMain.new(HttpPartyService.new, ImportArtistsYml.new)
    importMain.spotify_import

    #Another way
    #importMain = ImportMain.new(RspotifyRequest.new, ImportArtistsTxt.new)
    #importMain.spotify_import
  end
end
