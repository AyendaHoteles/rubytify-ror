require 'rspotify'
require 'ostruct'
require_relative 'ArtistProcess'
require_relative 'AlbumProcess'
require_relative 'SongProcess'
namespace :readartists do
  desc "load data from file yaml"
  task :read_file => :environment do
    require 'yaml'
    config =YAML.load_file('artists.yaml')
    artistsArray = []
    config.each do |key, value|
      artistsArray = value
      #Define artist
      artistsArray.each do |valueArtist|
        artisProcessObject = ArtistProcess.new
        artistObject = artisProcessObject.processArtistName(valueArtist)  
        if(artistObject != "error")
          #Process and Define Albums
          albumProcessObject = AlbumProcess.new
          albumObjetc = albumProcessObject.processAlbums(artistObject.object,artistObject.id, artistObject.albums, artistObject.genres)
          #consulting the songs 
            if(albumObjetc != "error")

            else
              puts "An error has occurred with the album #{albumObjetc.name.to_s}"  
            end
        else
          puts "An error has occurred with the artist #{valueArtist.to_s}"
        end  
      end    
    end
  end
end

namespace :util do
desc "random"
task :random => :environment do
  arrExample = ["pepe","tina","tola"]
  initNumber = 0
  limitNumber = 5
  prng = Random.new
  prng.rand(limitNumber)
  aleatory = prng
  strEx = arrExample[Random.rand(3)]
  cat = OpenStruct.new(color: 'black')
  puts cat.class
  puts cat.color
  puts  strEx
  end
end