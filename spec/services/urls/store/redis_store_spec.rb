# frozen_string_literal: true

require 'rails_helper'

describe Urls::Store::RedisStore do
  let(:short_url) { 'http://short-url' }
  let(:original_url) { 'http://original-url' }

  it_should_behave_like 'urls store'

  it 'saves url to redis' do
    described_class.call(original_url, short_url)
    result = RedisService.read(short_url)
    expect(result).to eq(original_url)
  end
end
