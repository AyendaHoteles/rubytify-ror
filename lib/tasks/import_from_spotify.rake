namespace :import_from_spotify do
  desc 'Import all info for the artists listed on the yaml file'
  task artists: :environment do
    artists = YAML.load_file('data/yaml/artists.yml')['artists']
    artists.each do |artist|
      ArtistImportJob.perform_later(artist.to_s)
    end
  end

  desc 'Import all albums info of the artist stored in db'
  task albums: :environment do
    artists = Artist.all
    artists.each do |artist|
      AlbumsImportJob.perform_later(
        artist_id: artist.id,
        artist_spotify_id: artist.spotify_id
      )
    end
  end

  desc 'Import all tracks info of the albums stored in db'
  task tracks: :environment do
    albums = Album.all
    albums.each do |album|
      AlbumsImportJob.perform_later(
        album_id: album.id,
        album_spotify_id: album.spotify_id
      )
    end
  end
end
