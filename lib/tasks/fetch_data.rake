require 'rspotify'

desc 'Fetch data from spotify'
task fetch_data: :environment do
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

  artists = YAML::load(File.open('lib/tasks/artists.yml'))

  artists.values.first.each do |artist|
    puts "FETCHING: #{artist.to_s}"

    artists = RSpotify::Artist.search(artist.to_s)

    artist_data = artists.first

    if artist_data.blank?
      puts "NO DATA FOR: #{artist.to_s}"
      next
    end

    image = artist_data.images.first

    artist = Artist.where(spotify_id: artist_data.id).first_or_create do |artist|
      artist.name = artist_data.name
      artist.image = image['url']
      artist.genres = artist_data.genres
      artist.popularity = artist_data.popularity
      artist.spotify_url = artist_data.external_urls['spotify']
    end

    albums = artist_data.albums

    albums.each do |album_data|
      image = album_data.images.first
      album = artist.albums.where(spotify_id: album_data.id).first_or_create do |album|
        album.name = album_data.name
        album.image = image['url']
        album.total_tracks = album_data.total_tracks || 0
        album.spotify_url = album_data.external_urls['spotify']
      end

      album_data.tracks do |track_data|
        album.songs.where(spotify_id: track_data.id).first_or_create do |track|
          track.name = track_data.name
          track.spotify_url = track_data.external_urls['spotify']
          track.preview_url = track_data.preview_url
          track.duration_ms = track_data.duration_ms
          track.explicit = track_data.explicit
          track.spotify_id = track_data.id
          track.artist_id = artist.id
        end
      end
    end
  end
end