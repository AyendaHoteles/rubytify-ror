class SpotifyImporter

  def import_artists
    artist_names = SpotifyImporter.load_yaml
    artist_names.each do |name|
      spotify_artist = SpotifyImporter.get_artist name
      local_artist = SpotifyImporter.create_artist spotify_artist

    end
  end

  class << self
    def create_albums local_artist, spotify_artist
      return unless local_artist&.persisted?
      artist.albums.each do |album|
        local_artist.albums.create(
            name: album.name,
            image: album.images&.first['url'],
            total_tracks: album.total_tracks,
            spotify_id: album.id,
            spotify_url: album.href
            )
      end

    end
    def create_artist artist
      Artist.create(
          name: artist.name,
          image: artist.images&.first['url'],
          popularity: artist.popularity,
          spotify_url: artist.href,
          spotify_id: artist.id
      )
    end

    def get_artist name
      RSpotify::Artist.search(name).first
    rescue
      return {mssg: "Artist with name #{name} not found"}
    end

    def load_yaml
      YAML.load_file(Rails.root.join('db', 'artists.yml'))['artists']
    end
  end
end