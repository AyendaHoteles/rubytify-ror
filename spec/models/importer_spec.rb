require 'rails_helper'

RSpec.describe Importer, :vcr do
  let!(:subject) { Importer.start }

  it 'doesnt broke' do
    expect(subject)
  end

  it 'create artists' do
    expect(Artist.count).to eq(3)
    expect(Artist.first.image).not_to be(nil)
  end

  it 'create albums' do
    expect(Album.count).to be > 0
    album = Album.first
    expect(album.image).not_to be(nil)
    expect(album.spotify_id).not_to be(nil)
    expect(album.spotify_url).not_to be(nil)
    expect(album.total_tracks).not_to be(nil)
  end

  it 'create songs' do
    expect(Song.count).to be > 0
  end

  it 'create genres' do
    expect(Genre.count).to be > 0
  end
end
