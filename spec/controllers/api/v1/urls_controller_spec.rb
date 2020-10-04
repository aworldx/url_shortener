# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UrlsController, type: :controller do
  let(:short_url) { 'http://short-url.com' }
  let(:original_url) { 'http://short-url.com' }
  let(:error_message) { 'some error' }

  context 'show action' do
    it 'returns status 200 and json' do
      get :show, params: { short_url: short_url }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns success json when stats dispatcher was success' do
      mock_success_service(service: Stats::Dispatcher, result: original_url)

      get :show, params: { short_url: short_url }

      expected_response = { success: true, result: original_url }
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'returns fail json when stats dispatcher was failed' do
      mock_failed_service(service: Stats::Dispatcher, error_message: error_message)

      get :show, params: { short_url: short_url }

      expected_response = { success: false, error: error_message }
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  context 'create action' do
    it 'returns status 200 and json' do
      post :create, params: { url: original_url }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns success json when urls creator was success' do
      mock_success_service(service: Urls::Creator, result: short_url)

      post :create, params: { url: original_url }

      expected_response = { success: true, result: short_url }
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'returns fail json when urls creator was failed' do
      mock_failed_service(service: Urls::Creator, error_message: error_message)

      post :create, params: { url: original_url }

      expected_response = { success: false, error: error_message }
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
