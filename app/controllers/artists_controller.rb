class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    json_response(@artists)
  end

end
