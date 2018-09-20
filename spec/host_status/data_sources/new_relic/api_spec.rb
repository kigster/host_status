require 'spec_helper'
require 'host_status/data_sources/new_relic'
require 'host_status/data_sources/new_relic/apm'
require 'host_status/data_sources/new_relic/api'
require 'awesome_print'

module HostStatus
  module DataSources
    module NewRelic
      describe API do
        let(:api_key) { '123445' }
        let(:app_id) { '00000' }

        before do
          HostStatus::DataSources::NewRelic.configure do |c|
            c.api_key = api_key
          end
        end

        subject(:api) { described_class.new(app_id: app_id) }

        describe '#hosts' do
          let(:application_response) { JSON.parse(File.read('spec/fixtures/newrelic_app.json')) }
          before do
            stub_request(:get, "https://api.newrelic.com/v2/applications/#{app_id}/hosts.json").
                to_return(
                    :status  => 200,
                    :body    => application_response.to_json,
                    :headers => { 'Content-Type' => 'application/json' })
          end

          its(:hosts) { should_not be_empty }
          its(:hosts) { should be_kind_of Array }

          describe 'first host' do
            subject(:host) { api.hosts.first }
            its(:name) { should eq 'crn001-a.prod.example.com' }
            its(:errors) { should eq 0 }
            its(:throughput) { should eq 0 }
          end
        end
      end
    end
  end
end
