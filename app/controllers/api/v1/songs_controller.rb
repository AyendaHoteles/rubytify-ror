class Api::V1::SongsController < ApplicationController
    def index
        songs = Song.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit)
                    .where(album_id: params[:album_id])
        # id property is still included but always null, so manually exclude it
        json_songs = []
        songs.each do |song|
            json_songs.push(song.as_json(except: :id))
        end
        render json: {data: json_songs}, status: :ok
    end

    def show_random
        songs = Song.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit)
                    .joins(album: :artist)
                    .where("artists.genres = ? OR artists.genres LIKE ? OR artists.genres LIKE ? OR artists.genres LIKE ?",
                        "%#{params[:genre_name]}%", "%|#{params[:genre_name]}%", "%|#{params[:genre_name]}|%", "%#{params[:genre_name]}|%")
        random_song = songs.sample(random: Random.new(1))
        render json: {data: random_song.as_json(except: :id)}, status: :ok
    end
end
