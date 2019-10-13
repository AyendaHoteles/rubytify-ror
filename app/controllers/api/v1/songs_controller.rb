class Api::V1::SongsController < ApplicationController
  def index
    render json: {name: "metallica"}.to_json , status: 201
  end
end
