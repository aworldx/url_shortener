# frozen_string_literal: true

require 'rails_helper'

describe Urls::Store::DbStore do
  let(:short_url) { 'http://short-url' }
  let(:original_url) { 'http://original-url' }

  it_should_behave_like 'urls store'

  it 'saves url to database' do
    described_class.call(original_url, short_url)
    record = ShortUrl.find_by(short_url: short_url)
    expect(record).to be_present
  end
end
