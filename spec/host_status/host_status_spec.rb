require 'spec_helper'

describe HostStatus do
  it 'has a version number' do
    expect(HostStatus::VERSION).not_to be nil
  end

  describe '#configure' do
    let(:api_key) { 'f9ccc660de48bd67aa478e73c2ae6b76' }
    before do
      HostStatus.configure do |config|
        config.adapters << :newrelic
      end
    end

    it 'returns configured value' do
      expect(described_class.config.adapters).to eq(%i(newrelic))
    end
  end
end
