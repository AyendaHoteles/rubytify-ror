namespace :spotify do
  desc "Load artists"
  task load: :environment do
    RSpotify.authenticate( "6b9a13d356e14f5d840c798a9fba8cb4", "097c088c26f64f938cce8b071dad0c9f")

    YAML.load_file("#{Rails.root}/public/artists.yml")['artists'].each do |artist|
      artist = RSpotify::Artist.search(artist.to_s).first
      artist_id = Artist.create(name: artist.name,
                        image: artist.images.sample['url'],
                        genres: artist.genres.to_a,
                        popularity: artist.popularity,
                        spotify_url: artist.external_urls['spotify'],
                        spotify_id: artist.id)

      artist.albums.each do |album|
        album_id = artist_id.albums.create(name: album.name,
                                           image: album.images.sample['url'],
                                           spotify_url: album.external_urls['spotify'],
                                           total_tracks: album.total_tracks,
                                           spotify_id: album.id)
        album.tracks.each do |song|
          song = album_id.songs.create(name: song.name,
                                       spotify_url: song.external_urls['spotify'],
                                       preview_url: song.preview_url,
                                       duration_ms: song.duration_ms,
                                       explicit: song.explicit,
                                       spotify_id: song.id)

        end
      end
      puts "#{artist_id.name} created"
    end

  end
end
