module Api
  module V1
    class SongsController < ApplicationController
      def index
        @data = Song.where(album_id: params['album_id'])
      end

      def show
        if rand_by_genre.nil?
          render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
        else    
          @data = rand_by_genre.albums.sample.songs.sample
        end
      end

      private

      def rand_by_genre
        genre = params['genre_name']
        @rand_by_genre ||= Artist.where("genres LIKE ?","%#{genre}%").sample
      end
    end
  end
end
