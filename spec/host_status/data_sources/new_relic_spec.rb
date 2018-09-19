require 'spec_helper'
require 'host_status/data_sources/new_relic'

module HostStatus
  module DataSources
    describe NewRelic do
      subject(:nr) { described_class.config }
      context 'without the api key' do
        before { described_class.configure { |c| c.api_key = nil } }
        its(:api_key) { should be_nil }
      end

      context 'set api_key' do
        let(:api_key) { '123409208' }
        before { nr.api_key = api_key }
        its(:api_key) { should eq api_key }
      end
    end
  end
end
