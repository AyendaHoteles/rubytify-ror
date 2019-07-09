module API
  module Entities
    class Album < Grape::Entity
      root 'data'

      expose :id, documentation: { type: 'Integer', desc: 'Internal id' }
      expose :name, documentation: { type: 'String', desc: 'Name' }
      expose :image, documentation: { type: 'String', desc: 'Image URL' }
      expose :spotify_url, documentation: { type: 'String', desc: 'Spotify URL' }
      expose :total_tracks, documentation: { type: 'Integer', desc: 'Total of Album tracks' }
    end
  end
end
