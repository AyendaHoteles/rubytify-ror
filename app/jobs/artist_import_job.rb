class ArtistImportJob < ApplicationJob
  queue_as :default

  def perform(artist)
    authenticate_to_spotify
    create_or_update_artist(artist)
  end

  private

  def create_or_update_artist(artist_name_to_look_for)
    search_results = RSpotify::Artist.search(artist_name_to_look_for)
    search_results.select do |search_result|
      search_result.name == artist_name_to_look_for
    end

    build_artist_params_hash_and_create_or_update_artist(search_results[0])
  end

  def build_artist_params_hash_and_create_or_update_artist(artist_raw_data)
    spotify_id = artist_raw_data.id

    artist = Artist.find_or_create_by(spotify_id: spotify_id)

    artist.update(
      name: artist_raw_data.name,
      image: artist_raw_data.images[0]['url'],
      genres: artist_raw_data.genres,
      popularity: artist_raw_data.popularity,
      spotify_url: artist_raw_data.external_urls['spotify'],
      spotify_id: spotify_id
    )
  end
end
