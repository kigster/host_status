require_relative '../spec_helper'

module HostStatus
  describe Application do
    let(:app_name) { 'Production' }
    let(:main_params) { { name: app_name } }
    let(:extra_params) { {} }
    let(:params) { main_params.merge(extra_params) }

    subject(:app) { described_class.new(params) }
    its(:name) { should eq app_name }

    describe 'with a url' do
      let(:url) { 'https://kig.re' }
      let(:extra_params) { { url: url } }
      its(:url) { should eq extra_params[:url]}
      its(:to_h) { should include(url: url )}
    end

    describe 'with app data' do
      let(:errors) { 0.01 }
      let(:throughput) { 34111 }
      let(:latency_p50) { 250 }
      let(:extra_params) { { errors: errors, throughput: throughput, latency_p50: latency_p50 } }

      its(:errors) { should eq errors }
      its(:throughput) { should eq throughput }
      its(:latency_p50) { should eq latency_p50 }

      describe 'out of bounds' do
        let(:throughput) { -1 }
        it 'should raise error' do
          expect { subject }.to raise_error
        end
      end
    end
  end
end

