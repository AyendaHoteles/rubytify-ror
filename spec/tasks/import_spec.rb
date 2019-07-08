# frozen_string_literal: true

require 'rails_helper'

describe 'rake import:spotify', :vcr, type: :task do
  let(:path) { 'spec/fixtures/artists.yml' }

  describe 'import' do
    it 'preloads the Rails environment' do
      expect(task.prerequisites).to include 'environment'
    end

    it 'runs gracefully with no errors' do
      expect { task.execute(path: path) }.not_to raise_error
    end

    it 'logs to stdout' do
      expect do
        task.execute(path: path)
      end.to output(/Import - Shopify: Started at/).to_stdout
      expect do
        task.execute(path: path)
      end.to output(/Import - Shopify: Finished at/).to_stdout
    end

    it 'expects a method call' do
      expect(Spotify::Importer).to receive(:call)
        .and_call_original

      task.execute(path: path)
    end
  end
end
