namespace :import_artist do

  require 'rspotify'
  require_relative '/home/jpoglas/rubytify-ror/app/models/application_record'
  require_relative '/home/jpoglas/rubytify-ror/app/models/artist'
  require_relative '/home/jpoglas/rubytify-ror/app/models/album'

  desc "loads the artist list from a yml file inside ythe project files and import the specified artists, all of their albums and songs"
  
  task load: :environment do
    artists =YAML.load_file('/home/jpoglas/rubytify-ror/config/artist_list.yml')
    artists['artists'].each do |artist|
      spt_artist = RSpotify::Artist.search(artist)
      puts spt_artist.first
      if !Artist.exists?("spotify_id = #{spt_artist.first.id}")
        n_image = spt_artist.first.images.first['url'] rescue nil
        n_url = spt_artist.first.external_urls['spotify'] rescue nil
        Artist.transaction do
          @id_artist = Artist.create(name: spt_artist.first.name,
                                    image: n_image,
                                    genres: spt_artist.first.genres,
                                    popularity:  spt_artist.first.popularity,
                                    spotify_url: n_url ,
                                    spotify_id: spt_artist.first.id).id
        end    
        n_artist_albums = spt_artist.first.albums
        n_artist_albums.each do |album|
          if !Album.exists?("spotify_id = #{album.id}") && album.album_type =='album'
            n_image =album.images.first['url'] rescue nil
            n_url = album.external_urls['spotify'] rescue nil
            Album.transaction do
              @id_album = Album.create(artist_id: @id_artist,
                                      name: album.name,
                                      image: n_image,
                                      spotify_url: n_url,
                                      total_tracks: album.total_tracks,
                                      spotify_id: album.id).id
            end                          
            n_artist_albums_songs = album.tracks
            n_artist_albums_songs.each do |song|
              n_url = song.external_urls['spotify'] rescue nil
              Song.transaction do
                Song.create(album_id: @id_album, 
                            name: song.name,
                            spotify_url: n_url,
                            preview_url: song.preview_url,
                            duration_ms: song.duration_ms,
                            explicit: song.explicit,
                            spotify_id: song.id
                )
              end
            end                         
          end                            
        end   
      end
    end  
  end

end



  