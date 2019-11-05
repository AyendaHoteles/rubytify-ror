class Api::V1::SongsController < ApplicationController
  def index
    render json: {data: Album.find(params[:album_id]).songs},
    except:[:created_at,:updated_at, :album_id, :id],
    status: :ok
  end
end
