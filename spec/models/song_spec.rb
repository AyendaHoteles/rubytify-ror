require 'rails_helper'

describe Song do
  context 'when create a song' do
    subject(:song) { build_stubbed(:song) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:album) }

    it { is_expected.to belong_to(:album) }
  end
end
