#!/usr/bin/env ruby
require 'rspotify'
require 'yaml'

artists = YAML.load(File.read("artists.yml"))
RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
# artists["artists"]
genres = []
artists["artists"].each do |artist|
 	artists = RSpotify::Artist.search(artist.to_s)
 	artic_monkeys = artists.first
 	# p artic_monkeys.name if artic_monkeys
	if artic_monkeys && artic_monkeys.genres.include?('rock')
		p artic_monkeys.genres
	end
	genres << artic_monkeys.genres if artic_monkeys
end
p genres.flatten.size
p genres.flatten.uniq.size
# album = RSpotify::Album.find('1jeMiSeSnNS0Oys375qegp')
# p album.tracks[0].name
# p album.tracks[0].external_urls["spotify"]
# p album.tracks[9].preview_url ? album.tracks[9].preview_url : 'not found'
#
# p album.tracks[0].duration_ms
# p album.tracks[0].explicit.class
# p album.tracks[0].id
#



# p artic_monkeys.instance_variables
# p rtists["artists"][0]
# artists = RSpotify::Artist.search(artists["artists"][0].to_s)
# artic_monkeys = artists.first
# p artic_monkeys.name if artic_monkeys
