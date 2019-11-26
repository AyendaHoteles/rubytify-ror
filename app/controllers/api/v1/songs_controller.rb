module Api
  module V1
    class SongsController < ApiController
      def index
        render json: { 'data': ActiveModelSerializers::SerializableResource.new(
          song_album, each_serializer: SongSerializer
        ) }
      end

      private

      def song_album
        Album.find(param_song_id).songs
      end

      def param_song_id
        params.require(:album_id)
      end
    end
  end
end
