require 'rails_helper'

RSpec.describe Importer do
  let(:subject) { Importer.start }

  it 'doesnt broke' do
    expect(subject)
  end
end
