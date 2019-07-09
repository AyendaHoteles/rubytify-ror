module API
  module Entities
    class Song < Grape::Entity
      root 'data', 'data'

      expose :name, documentation: { type: 'String', desc: 'Name' }
      expose :spotify_url, documentation: { type: 'String', desc: 'Spotify URL' }
      expose :preview_url, documentation: { type: 'String', desc: 'Spotify preview URL' }
      expose :duration_ms, documentation: { type: 'Integer', desc: 'Duration in milliseconds' }
      expose :explicit, documentation: { type: 'Boolean', desc: 'Explicit content' }
    end
  end
end
