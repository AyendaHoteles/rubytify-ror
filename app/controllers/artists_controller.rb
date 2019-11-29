class ArtistsController < ApplicationController

  def index
    @artists = Artist.all

    render json: custom_parser( @artists.order(popularity: :desc).as_json.each{ |p| p["genres"] = p["genres"].pluck("name") } )
  end
  
end
