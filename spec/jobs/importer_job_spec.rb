require 'rails_helper'

RSpec.describe [ArtistImportJob, TracksImportJob, AlbumsImportJob], type: :job do
  scenario 'imports sucessfully one artists, his albums and songs' do
    ActiveJob::Base.queue_adapter = :test
    ArtistImportJob.perform_now('Carlos Vives')
    expect(Artist.count).to eq 1
    AlbumsImportJob.perform_now(
      artist_id: Artist.last.id,
      artist_spotify_id: Artist.last.spotify_id
    )
    Artist.last.albums.each do |album|
      TracksImportJob.perform_now(
        album_id: album.id,
        album_spotify_id: album.spotify_id
      )
    end
    expect(Album.count).to eq 20
    expect(Song.count).to eq 240
  end
end
