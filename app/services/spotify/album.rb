module Services::Spotify
  class Album < Services::Spotify::Base
    class << self
      def all(artist_id)
        req = new("/artists/#{artist_id}/albums")
        req.class.get(
          req.service,
          headers: req.options[:headers]
        )['items']
      end
    end
  end
end
