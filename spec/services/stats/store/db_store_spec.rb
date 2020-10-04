# frozen_string_literal: true

require 'rails_helper'

describe Stats::Store::DbStore do
  let(:short_url) { 'http://short-url.com' }
  let(:original_url) { 'http://short-url.com' }
  let!(:url) { ShortUrl.create(short_url: short_url, original_url: original_url) }

  it 'increments clicks count and returns original url' do
    use_case = described_class.call(short_url, :original_url)
    expect(use_case.result).to eq(original_url)
    expect(url.reload.clicks_count).to eq(1)

    described_class.call(short_url, :original_url)
    expect(url.reload.clicks_count).to eq(2)
  end

  it 'returns clicks count' do
    use_case = described_class.call(short_url, :clicks_count)
    expect(use_case.result).to eq(0)

    url.update_column(:clicks_count, 6)

    use_case = described_class.call(short_url, :clicks_count)
    expect(use_case.result).to eq(6)
  end
end
