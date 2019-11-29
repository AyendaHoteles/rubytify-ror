
namespace :spotify do
    desc "This Task fills the Information Models"

    task fetch: :environment do 
      puts "&&&&&&&&&& Init Task &&&&&&&&&&"

      artists_names = YAML.load(File.read("lib/artists.yml"))["artists"]
      spotify = Spotify.new artists_names

      puts ' Setting Artists '
      spotify.set_artists
      puts ' Setting Albums '
      spotify.set_albums
      puts ' Setting Songs '
      spotify.set_songs

      puts "&&&&&&&&&& End Task &&&&&&&&&&"
    end
  end