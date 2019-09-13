class GenresController < ApplicationController
  def index
    @gender = Gender.find(params[:id])
    json_response(@gender.songs)
  end

end
