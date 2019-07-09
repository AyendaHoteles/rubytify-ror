module API
  module Entities
    class Artist < Grape::Entity
      root 'data'

      expose :id, documentation: { type: 'Integer', desc: 'Internal id' }
      expose :name, documentation: { type: 'String', desc: 'Name' }
      expose :image, documentation: { type: 'String', desc: 'Image URL' }
      expose :genres, documentation: { type: 'Array', desc: 'Associated genres' }
      expose :popularity, documentation: { type: 'Integer', desc: 'Popularity' }
      expose :spotify_url, documentation: { type: 'String', desc: 'Spotify URL' }
    end
  end
end
