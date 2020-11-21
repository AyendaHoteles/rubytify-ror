require 'rspotify'
require 'yaml'

namespace :db do
  desc "Clean and populate the data"
  task clean_and_populate: :enviroment do
    Rake::Task['db:reset'].invoke
  
    RSpotify.authenticate('2ad226a497a74801ac23bdd570e3069d', 'af6cd959f6e246b8aa2558ca442729bc')

    # "Saves the artist info"
    puts "Importing artist from Spotify"
    artists = YAML.safe_load(File.read('artist.yml'))
    
    artists['artists'].each do |artist|
      artist = RSpotify::Artist.search(artist.to_s).first
      f_artist = artist.first
      
      if f_artist
        n_artist = Artist.create({
          name: f_artist.name,
          image: f_artist.images.first['url'],
          popularity: f_artist.popularity,
          spotify_url: f_artist.external_urls['spotify'],
          spotify_id: f_artist.id
        })
        n_artist.save!
        f_artist.genres.each do |genre|
          begin
            n_genre = Genre.create({name: genre})
            n_genre.save!
            n_artist.genres << n_genre
          rescue => exception
          end
          e_genre = Genre.find_by(name: n_genre.name)
          n_artist.genres << e_genre unless n_artist.genres.include?(e_genre)
        end
      end
    # end for artists
    end
  
    puts "Importing artist from Albums"
    artists = Artist.all
    artists.each do |artist|
      albums = RSpotify::Artist.search(artist.name).first.albums
      albums.each do |album|
        n_album = Album.create({
            name: album.name,
            image: album.images.first['url'],
            spotify_url: album.external_urls['spotify'],
            total_tracks: album.total_tracks,
            spotify_id: album.id,
            artist_id: artist.id
        })
        n_album.save!
      end 
    end
  
    puts "Importing songs from Spotify"
    albums = Album.all
    albums.each do |album|
      c_album = RSpotify::Album.find(album.spotify_id)
      if c_album
        songs = c_album.tracks
        songs.each do |song|
          track = Song.create({
            name: song.name,
            spotify_url: song.external_urls['spotify'],
            spotify_id: song.id,
            preview_url: song.preview_url,
            duration_ms: song.duration_ms,
            explicit: song.explicit,
            album_id: album.id
          })
          track.save!
        end
      end  
    end
  #end task clean_and_populate
  end

#end namespace
end
