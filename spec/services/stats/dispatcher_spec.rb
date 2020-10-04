# frozen_string_literal: true

require 'rails_helper'

describe Stats::Dispatcher do
  let(:original_url) { 'http://original-url.com' }

  it 'returns success if store service was success' do
    mock_success_service(service: Stats::Store::DbStore, result: original_url)

    use_case = described_class.call(original_url, :original_url)
    expect(use_case.success?).to be_truthy
  end

  it 'fails if store service was failed' do
    mock_failed_service(service: Stats::Store::DbStore, error_message: 'some error')

    use_case = described_class.call(original_url, :original_url)
    expect(use_case.success?).to be_falsy
  end

  it 'calls db store when config contains db setting' do
    Rails.configuration.stubs(:store_service).returns(:db)
    mock_success_service(service: Stats::Store::DbStore, result: original_url)

    described_class.call(original_url, :original_url)
  end

  it 'calls db store when config is empty' do
    Rails.configuration.stubs(:store_service).returns(nil)
    mock_success_service(service: Stats::Store::DbStore, result: original_url)

    described_class.call(original_url, :original_url)
  end

  it 'calls redis store when config contains redis setting' do
    Rails.configuration.stubs(:store_service).returns(:redis)
    mock_success_service(service: Stats::Store::RedisStore, result: original_url)

    described_class.call(original_url, :original_url)
  end
end
