require 'rails_helper'

describe Artist do
  context 'when create a artist' do
    subject(:artist) { build_stubbed(:artist) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:albums) }
  end
end
