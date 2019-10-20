# Rakefile
# frozen_string_literal: true

require 'rspotify'

namespace :db do
  namespace :seed do
    desc 'Load collection decribed by "artist.yml" file from Spotify API'

    task :collection => :environment do
      artist_names = YAML.load_file("#{Rails.root.to_s}/lib/tasks/artists.yml")
      RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'])
      for i in (0..artist_names.size - 1) do
      #for i in (0..1) do
        spt_artist = RSpotify::Artist.search(artist_names["Artist_#{i}"]).first

        artist = Artist.new
        artist.name = spt_artist.name
        artist.image = spt_artist.images.first['url']
        artist.genres = spt_artist.genres.join(', ')
        artist.spotify_id = spt_artist.id
        artist.popularity = spt_artist.popularity
        artist.spotify_url = spt_artist.external_urls['spotify']

        if artist.save
          spt_artist.albums.each do |spt_album|
            spt_tracks = spt_album.tracks
            album = Album.new
            album.name = spt_album.name
            album.image = spt_album.images.first['url']
            album.spotify_id = spt_album.id
            album.total_tracks = spt_tracks.size
            album.spotify_url = spt_album.external_urls['spotify']
            artist.albums << album

            if album.save
              spt_tracks.each do |spt_track|
                song = Song.new
                song.name = spt_track.name
                song.explicit = spt_track.explicit# && song.explicit
                song.spotify_id = spt_track.id
                song.preview_url = spt_track.preview_url || "https://open.spotify.com/track"
                song.duration_ms = spt_track.duration_ms
                song.spotify_url = spt_track.external_urls['spotify']
                album.songs << song
                unless song.save
                  puts song.errors.messages
                end
              end
            end
          end
        end
      end
    rescue Exception => e
      puts "Exception " + e.inspect
      puts e.backtrace
    end
  end
end