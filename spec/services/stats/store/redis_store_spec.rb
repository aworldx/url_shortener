# frozen_string_literal: true

require 'rails_helper'

describe Stats::Store::RedisStore do
  let(:short_url) { 'http://short-url.com' }
  let(:original_url) { 'http://short-url.com' }
  let(:counter_key) { "#{short_url}_counter" }

  before(:each) { RedisService.write(short_url, original_url) }

  it 'increments clicks count and returns original url' do
    use_case = described_class.call(short_url, :original_url)
    expect(use_case.result).to eq(original_url)
    expect(RedisService.read(counter_key).to_i).to eq(1)

    described_class.call(short_url, :original_url)
    expect(RedisService.read(counter_key).to_i).to eq(2)
  end

  it 'returns clicks count' do
    use_case = described_class.call(short_url, :clicks_count)
    expect(use_case.result).to eq(0)

    RedisService.write(counter_key, 6)

    use_case = described_class.call(short_url, :clicks_count)
    expect(use_case.result).to eq(6)
  end
end
