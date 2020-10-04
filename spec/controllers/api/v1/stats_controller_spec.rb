# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::StatsController, type: :controller do
  let(:short_url) { '2kjn12sdf2' }

  context 'index action' do
    it 'returns status 200 and json' do
      get :index, params: { url_short_url: short_url }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns success json when stats dispatcher was success' do
      mock_success_service(service: Stats::Dispatcher, result: 10)

      get :index, params: { url_short_url: short_url }

      expected_response = { success: true, result: 10 }
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'returns fail json when stats dispatcher was failed' do
      mock_failed_service(service: Stats::Dispatcher, error_message: 'some error')

      get :index, params: { url_short_url: short_url }

      expected_response = { success: false, error: 'some error' }
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
