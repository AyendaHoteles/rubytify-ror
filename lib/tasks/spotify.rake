require "i18n"
require_relative '../modules/ayenda_request.rb'

include AyendaRequest

namespace :spotify do
    desc "This Task fills the Information Models"

    task fetch: :environment do  
      puts "&&&&&&&&&& Init Task &&&&&&&&&&"
      # declare variables
      artists_names = []
      artists_ids = []
      request = nil
      current_name = nil
      albums_dictionary = {}
      tracks_dictionary = {}
      # ...........................

      # Get Artists Id's
      AyendaRequest::set_token
      artists_names = YAML.load(File.read("lib/artists.yml"))["artists"]

      # ............... Get Artists ...............
      puts ' Getting artists '
      artists_names.each do | single_name | 
      
        single_name = I18n.transliterate( single_name.to_s )
        single_name.to_s.match(/\s+/) ? current_name = single_name.to_s.gsub(/\s+/, '+') : current_name = single_name.to_s

        request = AyendaRequest.get_request( SpotifyConstants.search_url.concat( "?type=artist&q=" ).concat( current_name ) )

        single_name = I18n.transliterate( single_name.to_s ).downcase
        single_name.gsub!(/\s+/, ' ') if single_name.match(/\s+/)
        
        request["artists"]["items"].each do |item|
          item["name"] = I18n.transliterate( item["name"].to_s ).downcase
          item["name"].gsub!(/\s+/, ' ') if item["name"].match(/\s+/)

          if  item["name"] == single_name
            artists_ids.push( item["id"] )
            # Set Artists ..........
            next if not Artist.find_by(spotify_id: item["id"]).nil?
            artist = Artist.new
            artist.name = item["name"]
            artist.image = item["images"][0]["url"] if not item["images"].blank?
            artist.genres = item["genres"]
            artist.popularity = item["popularity"]
            artist.spotify_url = item["href"]
            artist.spotify_id = item["id"]
            artist.save!
            # ......................
            break;
          end
        end
      end
      puts ' End getting artists '
      # ............................................
      
      # ............... Get Albums ...............
      puts ' Getting albums '
      artists_ids.each do | art_id |
        request = AyendaRequest.get_request( SpotifyConstants.artists_url.concat( art_id ).concat("/albums") )

        albums_dictionary[art_id] = request["items"].pluck("id")
        
        request["items"].each do | item |
          # Set Albums .......... 
            next if not Album.find_by(spotify_id: item["id"]).nil?
            album = Album.new
            album.artist = Artist.find_by!(spotify_id: art_id )
            album.name = item["name"]
            album.image = item["images"][0]["url"] if not item["images"].blank?
            album.spotify_url = item["href"]
            album.total_tracks = item["total_tracks"]
            album.spotify_id = item["id"]

            album.save!
          # ..................... 
        end
      end
      puts ' End getting albums '
      # ..........................................
      
      # ............... Get Tracks ...............
      puts ' Getting songs '
      albums_dictionary.keys.each do | key |
        albums_dictionary[ key ].each do | album |
          request = AyendaRequest.get_request( SpotifyConstants.albums_url.concat( album ).concat("/tracks") )
          tracks_dictionary[ key ] = request["items"].pluck("id")

          request["items"].each do | item |
            # Set Tracks .......... 
            next if not Song.find_by(spotify_id: item["id"]).nil?
            song = Song.new
            song.album = Album.find_by!(spotify_id: album)
            song.name = item["name"]
            song.spotify_url = item["href"]
            song.preview_url = item["preview_url"]
            song.duration_ms = item["duration_ms"]
            song.explicit = item["explicit"]
            song.spotify_id = item["id"]
            
            song.save!
            # ..................... 
          end
        end
      end
      puts ' End getting songs '
      # ..........................................
      puts "&&&&&&&&&& End Task &&&&&&&&&&"
    end
  end