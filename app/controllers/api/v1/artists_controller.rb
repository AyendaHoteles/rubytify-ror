class Api::V1::ArtistsController < ApplicationController

  def index
    render json: { data: serializable_data(Artist.order_by_popularity) }
  end

end
