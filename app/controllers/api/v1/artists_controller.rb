class Api::V1::ArtistsController < ApplicationController

  def index
    get_answer
  end

  private
    def get_answer
      array = []
      artist_list = Artist.all.order(popularity: :desc)
      artist_list.each do |a|
        gender_list = []
        a.genders.each do |g|
          gender_list << g.name
        end
        new_object = { id: a.id, name: a.name, image: a.image, genres: gender_list, popularity: a.popularity, spotify_url: a.spotify_url, spotify_id: a.spotify_id }
        array << new_object
      end
      answer = { data: array }
      json_response(answer)
    end

end
