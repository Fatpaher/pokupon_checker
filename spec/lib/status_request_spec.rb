require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe StatusRequest do
  describe '#call' do
    it 'sends request to URLS' do
      requests = described_class::URLS.map do |url|
        stub_request(
          :get,
          url,
        ).to_return(status: 200)
      end

      described_class.new.call

      requests.each do |request|
        expect(request).to have_been_made.once
      end
    end

    it 'returns array of statuses' do
      described_class::URLS.map do |url|
        stub_request(
          :get,
          url,
        ).to_return(status: 200)
      end

      result = described_class.new.call

      expected_result = described_class::URLS.map do |url|
        [url, '200']
      end.to_h

      expect(result).to eq(expected_result)
    end
  end
end
