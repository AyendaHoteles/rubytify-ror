module Api
    module V1
        class SongsController < ApplicationController
            def index
                songs = Song.where(album_id: params[:album_id])
                render json: SongSerializer.new(songs).as_json
            end
            def random_song
                songs = Song.joins(album: [:artist]).where("genres like '%#{params[:genre_name]}%'").order('RANDOM()').first
                render json: SongSerializer.new(songs).as_json
            end           
        end    
    end
end    