# frozen_string_literal: true

require 'rails_helper'

describe Urls::Creator do
  let(:short_url) { 'http://short-url' }
  let(:original_url) { 'http://original-url' }

  it 'is success when encryptor and store service are success' do
    mock_success_service(service: Urls::Encryptor, result: short_url)
    mock_success_service(service: Urls::Store::DbStore, result: short_url)

    use_case = described_class.call(original_url)

    expect(use_case.success?).to be_truthy
    expect(use_case.result).to eq("#{Rails.configuration.base_url}/#{short_url}")
  end

  it 'fails if encryptor was failed' do
    mock_failed_service(service: Urls::Encryptor, error_message: 'some error')

    use_case = described_class.call(original_url)

    expect(use_case.success?).to be_falsy
  end

  it 'fails if store service was failed' do
    mock_success_service(service: Urls::Encryptor, result: short_url)
    mock_failed_service(service: Urls::Store::DbStore, error_message: 'some error')

    use_case = described_class.call(original_url)

    expect(use_case.success?).to be_falsy
  end

  it 'calls db store when config contains db setting' do
    Rails.configuration.stubs(:store_service).returns(:db)
    mock_success_service(service: Urls::Store::DbStore, result: short_url)

    described_class.call(original_url)
  end

  it 'calls db store when config is empty' do
    Rails.configuration.stubs(:store_service).returns(nil)
    mock_success_service(service: Urls::Store::DbStore, result: short_url)

    described_class.call(original_url)
  end

  it 'calls redis store when config contains redis setting' do
    Rails.configuration.stubs(:store_service).returns(:redis)
    mock_success_service(service: Urls::Store::RedisStore, result: short_url)

    described_class.call(original_url)
  end
end
