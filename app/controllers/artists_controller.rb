class ArtistsController < ApplicationController
  def index
    @data = Artist.all
  end
end