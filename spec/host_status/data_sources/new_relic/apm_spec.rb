require 'spec_helper'
require 'host_status/data_sources/new_relic/apm'
require 'awesome_print'

module HostStatus
  module DataSources
    module NewRelic
      describe APM do
        subject(:app) { APM.new(params) }

        let(:app_name) { 'NewRelic App' }
        let(:errors) { 0.01 }
        let(:throughput) { 34111 }
        let(:latency_p50) { 250 }
        let(:process_count) { 5 }

        let(:main_params) { { name: app_name } }

        let(:extra_params) do
          {
              response_time:  latency_p50,
              throughput:     throughput,
              error_rate:     errors,
              apdex_score:    nil,
              instance_count: process_count }
        end

        let(:params) { main_params.merge(extra_params) }

        its(:name) { should eq app_name }
        its(:errors) { should eq errors }
        its(:throughput) { should eq throughput }
        its(:latency_p50) { should eq latency_p50 }
      end
    end
  end
end
