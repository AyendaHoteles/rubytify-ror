class Api::V1::ArtistsController < ApplicationController
  def index
    render json: {data: Artist.all.order(popularity: :desc)},
    except: [:created_at, :updated_at],
    status: :ok
  end
end
