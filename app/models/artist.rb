# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  genres      :string
#  image       :string
#  name        :string
#  popularity  :integer
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Artist < ApplicationRecord
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :songs
  has_many                :albums

  validates :name, :spotify_url, presence: true
  
  def self.parse(spotify_response:)
    {
      name:        spotify_response["name"],
      image:       spotify_response["images"].first["url"],
      genres:      spotify_response["genres"],
      popularity:  spotify_response["popularity"],
      spotify_url: spotify_response.dig.("external_urls","spotify")
    }
  end

  def create_body
    genres = Genre.where(:artist_id == self.id)

    {
      id:          self.id,
      name:        self.name,
      image:       self.image,
      genres:      genres.map(&:name).join(", "),
      popularity:  self.popularity,
      spotify_url: self.spotify_url
    }
  end

  def self.create_artist(name: "Metallica")
    response = Spotify::ComunicationService.get_artist(name: name)

    response_parsed = Spotify::ParserService.artist(spotify_response: response)

    response_parsed[:genres].each { |genre_name| Genre.find_or_create_by(name: genre_name) } 

    new_artist = Artist.create(
      id:          response_parsed[:id],
      name:        response_parsed[:name].capitalize,
      image:       response_parsed[:image],
      popularity:  response_parsed[:popularity],
      spotify_url: response_parsed[:spotify_url]
    )

    add_genres(artist: new_artist, genres_names: response_parsed[:genres])
  end

  def self.add_genres(artist:, genres_names:)
    genres_names.each do |name|
      artist.genres << Genre.find_by(name: name)
    end
  end
end
