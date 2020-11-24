class ArtistsController < ApplicationController
  require 'rspotify'

  def index
    @artists = RSpotify::Artist.search('Arctic Monkeys')
  end

  def show
    @artist = RSpotify::Artist.find(params[:id])
  end
end
