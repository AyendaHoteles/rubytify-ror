module Api
  module V1
    class RandomSongController < ApiController
      def index
        render json: { 'data': ActiveModelSerializers::SerializableResource.new(
          random_song, each_serializer: SongSerializer
        ) }
      end

      private

      def random_song
        artist_random.songs.order('RANDOM()').first
      end

      def artist_random
        @artists = Artist.where("'#{param_genre}' = ANY (genres)").order('RANDOM()')

        @artists.each do |artist|
          return artist if artist.songs.exists?
        end
      end

      def param_genre
        params.require(:genre_id)
      end
    end
  end
end
