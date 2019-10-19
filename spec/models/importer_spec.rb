require 'rails_helper'

RSpec.describe Importer, :vcr do
  let(:subject) { Importer.start }

  it 'doesnt broke' do
    expect(subject)
  end

  it 'create correct number artists' do
    subject
    expect(Artist.count).to eq(3)
    expect(Artist.first.image).not_to be(nil)
  end

  it 'create genres' do
    subject
    expect(Genre.count).to be > 0
  end
end
