
  class ArtistClient < Spotify
    def fetch
      Artist.delete_all
      artist_names.each do |name|
        save(search(name))
      end 
    end

    private

    def save(artist)
      Artist.create(
        name: artist['name'],
        image: artist['images'],
        genres: artist['genres'],
        popularity: artist['popularity'],
        spotify_url: artist['external_urls']['spotify'],
        spotify_id: artist['id']
      )
    end

    def search(name)
      JSON.parse(super(name))['artists']['items'][0]
    end

    def query_url(name)
      "https://api.spotify.com/v1/search?q=artist:#{name}&type=artist&limit=1"
    end

    def artist_names
      YAML.load(File.read(artists_file)).with_indifferent_access['artists'] 
    end

    def artists_file
      Rails.root.join('db','artists_list.yml')
    end
  end
