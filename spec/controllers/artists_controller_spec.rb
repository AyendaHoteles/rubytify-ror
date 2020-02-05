require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  fixtures :albums, :songs, :artists

  describe 'Artists routing' do
    it { should route(:get, 'api/v1/artists').to(action: :index) }
    it { should route(:get, 'api/v1/artists/1/albums').to(action: :albums, id: 1) }
  end
end
