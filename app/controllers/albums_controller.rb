class AlbumsController < ApplicationController
  before_action :exists_artist, only: [:index]
  
  def index
    if params[:artist_id]
      @albums = Artist.find(params[:artist_id]).albums
    else
      @albums = Album.all
    end
    
    render json: custom_parser( @albums )
  end

  private
    def exists_artist
      render json: {"message":"The artist with id ".concat( params[:artist_id] ).concat( " does not exist." )}, 
      status: :bad_request if Artist.find_by(id: params[:artist_id]).nil? and not params[:artist_id].nil?
    end
end
