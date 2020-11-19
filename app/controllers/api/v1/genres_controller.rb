module Api
  module V1
      class GenresController < ApplicationController
        def aleatory_song_by_gender
          genre_service = GenresService.new
          @song = genre_service.get_song_by_gender_aleatory(params[:genre_name])
          if @song.present?
            render json: @song, root: 'data', adapter: :json, each_serializer: SongSerializer
          else
            render :json => {msg: "song of genre #{params[:genre_name]}, not found "}.to_json, :status => 404 
          end
        end

      end
  end
end