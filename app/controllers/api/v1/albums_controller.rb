module Api
  module V1
    class AlbumsController < ApiController
      def index
        render json: { 'data': ActiveModelSerializers::SerializableResource.new(
          artist.albums, each_serializer: AlbumSerializer
        ) }
      end

      private

      def artist
        @artist ||= Artist.find(param_artist_id)
      end

      def param_artist_id
        params.require(:artist_id)
      end
    end
  end
end
