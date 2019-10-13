class Api::V1::ArtistsController < ApplicationController
  def index
     render json: {name: "david"}.to_json , status: 201
  end

  def albums
    render json: {name: "metallica"}.to_json , status: 201
  end
end
