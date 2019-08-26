module Api
  module V1
    class SongsController < ApplicationController
      def index
        @songs = Song.where("album_id = ?", params[:id])
        render json: Response.new(@songs.as_json)
      end

      def by_genre
        @artist = Artist.where("genres LIKE '%#{params[:genre_name]}%'")
          .order("RANDOM()")
          .limit(1)

        @album = Album.where("artist_id = ?", @artist[0].spotify_id)
          .order("RANDOM()")
          .limit(1)

        @song = Song.where("album_id = ?", @album[0].spotify_id)
          .order("RANDOM()")
          .limit(1)

        render json: Response.new(@song.as_json)
      end
    end
  end
end
