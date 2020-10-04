# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UrlsController, type: :controller do
  context 'show action' do
    it 'returns status 200 and json' do
      get :show, params: { short_url: 'http://short-url.com' }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns success json when stats dispatcher was success' do
      mock_success_service(service: Stats::Dispatcher, result: 'http://original-url.com')

      get :show, params: { short_url: 'http://short-url.com' }

      expected_response = { success: true, result: 'http://original-url.com' }
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'returns fail json when stats dispatcher was failed' do
      mock_failed_service(service: Stats::Dispatcher, error_message: 'some error')

      get :show, params: { short_url: 'http://short-url.com' }

      expected_response = { success: false, error: 'some error' }
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  context 'create action' do
    it 'returns status 200 and json' do
      post :create, params: { url: 'http://original-url.com' }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns success json when urls creator was success' do
      mock_success_service(service: Urls::Creator, result: 'http://short-url.com')

      post :create, params: { url: 'http://original-url.com' }

      expected_response = { success: true, result: 'http://short-url.com' }
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'returns fail json when urls creator was failed' do
      mock_failed_service(service: Urls::Creator, error_message: 'some error')

      post :create, params: { url: 'http://original-url.com' }

      expected_response = { success: false, error: 'some error' }
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
