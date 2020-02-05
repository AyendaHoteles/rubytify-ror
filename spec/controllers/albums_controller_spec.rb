require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  fixtures :albums, :songs, :artists

  describe 'Albums routing' do
    it { should route(:get, 'api/v1/albums/1/songs').to(action: :songs, id: 1) }
  end
end
