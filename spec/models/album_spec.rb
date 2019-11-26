require 'rails_helper'

describe Album do
  context 'when create a album' do
    subject(:album) { build_stubbed(:album) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:artist) }

    it { is_expected.to have_many(:songs) }
    it { is_expected.to belong_to(:artist) }
  end
end
