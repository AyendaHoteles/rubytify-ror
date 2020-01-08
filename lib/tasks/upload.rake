desc 'Importer artist list'

namespace :upload do
  task artists: :environment do
    puts "upload artists..!"
    file = File.expand_path('../artists.yml', __FILE__)
    RSpotify::authenticate(ENV['SPOTIFY_ACCESS_KEY_ID'], ENV['SPOTIFY_SECRET_ACCESS_KEY'])
    if File.exists?(file)
      config = YAML.load_file(file)
      config.fetch('artists', {}).each do |key, value|
        fetchSpotify (key)
      end
    end
    puts 'uplooad artist end..!!'
  end
end

def fetchSpotify(nameArtist)
  artists = RSpotify::Artist.search(nameArtist.to_s)
  firstArtist = artists.first
  if firstArtist
    artist = createArytist(firstArtist.name, firstArtist.popularity, firstArtist.genres.first, firstArtist.images.first['url'], firstArtist.external_urls['spotify'])
    firstArtist.albums.each do |album|
       albumRecord = createAlbum(album.name, album.images.first['url'], album.external_urls['spotify'], album.total_tracks, artist.id)
       songs = album.tracks
       songs.each do |song|
         createSong(song.name, song.duration_ms, song.explicit, song.preview_url, song.external_urls['spotify'], albumRecord.id)
       end
    end
  end
end

def createArytist(name, popularity, genres, images, external_urls)
  artist = Artist.create(name: name, genres: genres, popularity: popularity, spotify_url: external_urls)
  return artist
end

def createAlbum(name, images, external_urls, total_tracks, artist_id)
  album = Album.create(name: name, image: images, spotify_url: external_urls, total_tracks: total_tracks, artist_id: artist_id)
  return album
end

def createSong(name, duration_ms, explicit, preview_url, external_urls, album_id)
  song = Song.create(name: name, spotify_url: external_urls, preview_url: preview_url,duration_ms: duration_ms.to_i, explicit: explicit, album_id: album_id)
  return song
end
