# frozen_string_literal: true

require 'rails_helper'

describe Urls::Encryptor do
  it 'returns string' do
    use_case = described_class.call('some_url')
    expect(use_case.result).to be_a(String)
  end

  it 'fails when nil passed' do
    use_case = described_class.call(nil)
    expect(use_case.success?).to be_falsy
  end

  it 'returns some value when empty string passed' do
    use_case = described_class.call('')
    expect(use_case.success?).to be_falsy
  end

  it 'returns uniq string' do
    set = Set.new

    100.times do |index|
      use_case = described_class.call("some_string#{index}")
      set << use_case.result
    end

    expect(set.size).to eq(100)
  end

  it 'returns same hash for same url' do
    use_case1 = described_class.call('some_url')
    use_case2 = described_class.call('some_url')

    expect(use_case1.result).to eq(use_case2.result)
  end
end
