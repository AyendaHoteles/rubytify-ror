class Api::V1::ArtistsController < ActionController::Base

  def artists
    artists = Artist.select(:id, :name, :genres, :popularity, :spotify_url).all
    render json: {data: artists}
  end

end
