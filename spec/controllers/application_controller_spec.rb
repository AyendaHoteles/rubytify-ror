# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotFoundHandler, type: :controller do
  controller do
    include NotFoundHandler

    def action
      raise ActiveRecord::RecordNotFound
    end
  end

  before do
    routes.draw { get :action, to: "anonymous#action" }
    get :action
  end

  describe 'handles not found' do
    it 'has status code not found' do
      expect(response).to have_http_status(404)
    end

    it 'has content type JSON' do
      expect(response.content_type).to eq('application/json')
    end
  end
end