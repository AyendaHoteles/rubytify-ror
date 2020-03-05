module Services::Spotify
  class Search < Services::Spotify::Base
    class << self
      def show(term, type)
        req = new('/search', {q: term, type: type})
        req.class.get(
          req.service,
          query: req.options[:query].merge(limit: 1),
          headers: req.options[:headers]
        )['artists']['items'].first
      end
    end
  end
end
