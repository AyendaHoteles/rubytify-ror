class ApplicationController < ActionController::API

  # /api/v1/artists
  def artists_all
    render json: { :data => Artist.select(:id, :name, :image, :genres, :popularity, :spotify_url) }.to_json
  end

  # /api/v1/artists/:id/albums
  def artists_albums_by_id
    render json: { :data => Album.select(:id, :name, :image, :spotify_url, :total_tracks).where(id_artist: params[:id]) }.to_json
  end

  # /api/v1/albums/:id/songs
  def songs_by_album
    render json: { :data => Song.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit).where(id_album: params[:id]) }.to_json
  end

  # /api/v1/genres/:genre_name/random_song
  def song_by_genre
    songs_list = Song.select(:name, :spotify_url, :preview_url, :duration_ms, :explicit, :genres)
      .joins("INNER JOIN albums ON songs.id_album = albums.id INNER JOIN artists ON albums.id_artist = artists.id")

    results_list = []

    for i in songs_list
      for item in i.genres
        if item == params[:genre_name]
          results_list.push("name" => i.name, "spotify_url" => i.spotify_url, "preview_url" => i.preview_url, "duration_ms" => i.duration_ms, "explicit" => i.explicit)
        end
      end
    end

    render json: { :data => results_list[Random.rand(0...results_list.length() - 1)] }.to_json
  end
end
