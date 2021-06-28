require_relative '../lib/tasks/ArtistProcess'
require_relative '../lib/tasks/ArtistCompose'
require 'rails_helper'
describe ArtistProcess do  
  describe '#processArtistName' do
    it('Processing an artist') do
      artisProcessobject = ArtistProcess.new
      expect(artisProcessobject.processArtistName('BTS')).to be_kind_of(ArtistCompose)
    end
  end
end