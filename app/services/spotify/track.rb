module Services::Spotify
  class Track < Services::Spotify::Base
    class << self
      def all(album_id)
        req = new("/albums/#{album_id}/tracks")
        req.class.get(
          req.service,
          headers: req.options[:headers]
        )['items']
      end
    end
  end
end
