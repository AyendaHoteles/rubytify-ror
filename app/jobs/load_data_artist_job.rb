class LoadDataArtistJob < ActiveJob::Base
  	queue_as :default

  	def perform(artist)
  		SpotifyLoad::DataArtist.call(artist)
  	end
end