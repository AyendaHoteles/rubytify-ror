require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  describe 'Genres routing' do
    it { should route(:get, 'api/v1/genres/rock/random_song').to(action: :random_song, genre_name: "rock") }
  end
end
