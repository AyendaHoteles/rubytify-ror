module Api
  module V1
    class ArtistsController < ApiController
      def index
        render json: { 'data': ActiveModelSerializers::SerializableResource.new(
          artists, each_serializer: ArtistSerializer
        ) }
      end

      private

      def artists
        Artist.all.order(popularity: :desc)
      end
    end
  end
end
