# frozen_string_literal: true

shared_examples 'urls store' do
  let(:short_url) { 'http://short-url' }
  let(:original_url) { 'http://original-url' }

  it 'does not contain errors when url is uniq' do
    described_class.call(original_url, short_url)

    use_case = described_class.call('http://another-original-url', 'http://another-short-url')
    expect(use_case.success?).to be_truthy
  end

  it 'fails when url is not uniq' do
    described_class.call(original_url, short_url)

    use_case = described_class.call(original_url, short_url)
    expect(use_case.success?).to be_falsy
  end

  it 'fails when url is empty' do
    use_case = described_class.call('', short_url)
    expect(use_case.success?).to be_falsy

    use_case = described_class.call(original_url, '')
    expect(use_case.success?).to be_falsy
  end
end
