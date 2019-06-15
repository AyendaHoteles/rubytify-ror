class Api::V1::AlbumsController < ActionController::Base

  def albums
    artist = Artist.where(id: params[:id])

    if artist.empty?
      render json: {message: "No matches found"}
    else
      albums = artist.first.albums.select(:id, :name, :image, :spotify_url, :total_tracks)
      render json: {data: albums}
    end
  end

end
