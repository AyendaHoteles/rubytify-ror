class Api::V1::AlbumsController < ApplicationController
  def index
    render json: {data: Artist.find(params[:artist_id]).albums},
    except:[:artist_id, :spotify_id, :created_at, :updated_at, :spotify_id],
    status: :ok
  end
end
