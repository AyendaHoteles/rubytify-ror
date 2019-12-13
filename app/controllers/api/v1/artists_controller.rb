class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.order(popularity: :desc)
    render json: { 'data': ActiveModelSerializers::SerializableResource.new(
      artists, each_serializer: ArtistSerializer,
    ) }
  end
end
