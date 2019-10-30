require 'yaml'
namespace :db do

  # Custom reset 
  desc "Reset"
  task :reset => ["db:drop", "db:create", "db:migrate", "db:test:prepare", "db:seed", "db:load_artists"]


  desc "load artists in database"
  task load_artists: do

  	Rake::Task['db:reset'].invoke
	base_artists = YAML.load(File.read("config/artists.yml"))
	print "artista: "
	base_artists.values[0].each do |artist|

	  artist_data= RSpotify::Artist.search(artist.to_s)
	  unless Artist.where(:spotify_id => artist_data.first.id).count > 0
	  	# print artist_data.first.name
         Artist.create!(
        	:name => artist_data.first.name,
        	:image => artist_data.first.images.first.values[1],
        	:popularity => artist_data.first.popularity,
        	:spotify_url => artist_data.first.external_urls.first[1],
        	:spotify_id => artist_data.first.id,
        	:genres => artist_data.first.genres
        	)

        	artist_data.first.albums.each do |album| 

	        	unless Album.where(:spotify_id => album.id).count > 0
	        		# print Artist.find_by(spotify_id: artist_data.first.id).albums.count
		        Artist.find_by(spotify_id: artist_data.first.id).albums.create!(
		        	:name => album.name,
		        	:image => album.images.first.values[1],
		        	:spotify_url => album.external_urls.first[1],
		        	:total_tracks => album.tracks.count,
		        	:spotify_id => album.id
		        	)   

			        album.tracks.each do |song|

			        	unless Song.where(:spotify_id => song.id).count > 0

			        		Album.find_by(:spotify_id => album.id).songs.create!(
			        			:name => song.name,
			        			:spotify_url => song.external_urls.first[1],
			        			:preview_url => song.preview_url,
			        			:duration_ms => song.duration_ms,
			        			:explicit => song.explicit,
			        			:spotify_id => song.id
			        			)

			        	end

			        end	

	        	end

        	end     	
      end		
		# print artist_data.first.genres



	end


	# artist_test= RSpotify::Artist.search(base_artists.values[0][0].to_str)
	# print artist_test.first.albums



	end

end


