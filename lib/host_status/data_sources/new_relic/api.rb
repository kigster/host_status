require 'httparty'

module HostStatus
  module DataSources
    module NewRelic
      class API
        # class << self
        #   def api
        #     @api ||= self.new
        #   end
        #
        #   def hosts
        #     api.hosts
        #   end
        #
        #   def rpm
        #     api.application.application.application_summary.throughput
        #   end
        # end
        #
        include HTTParty

        base_uri 'https://api.newrelic.com/v2/'

        attr_writer :api_key
        attr_accessor :app_id

        def initialize(api_key: nil, app_id: nil)
          self.api_key = api_key
          self.app_id  = app_id
          self.class.headers 'X-Api-Key' => api_key
        end

        def api_key
          @api_key ||= HostStatus::DataSources::NewRelic.config.api_key
        end

        def application(app_id = nil)
          fetch_application(app_id)
        end

        def hosts(app_id = nil)
          response = fetch_hosts(app_id)
          return nil unless response && !response.empty?
          response.application_hosts.map do |host|
            hs = host.application_summary.to_h
            hs[:name] = host.host
            Hashie::Extensions::SymbolizeKeys.symbolize_keys!(hs)
            hs ? APM.new(**hs) : nil
          end.compact
        end

        private

        def fetch_application(aid = nil)
          with_app_id(aid) do |app_id|
            get("/applications/#{app_id}.json")
          end
        end

        def fetch_hosts(aid = nil)
          with_app_id(aid) do |app_id|
            get("/applications/#{app_id}/hosts.json")
          end
        end

        def with_api_key
          raise ArgumentError, "NewRelic API Key must be set" if api_key.nil?
          yield
        end

        def with_app_id(app_id = nil)
          aid = app_id || self.app_id
          raise ArgumentError, "NewRelic App ID must be set for this call" if aid.nil?
          with_api_key do
            yield(aid)
          end
        end

        def get(*args)
          response = Hashie::Mash.new(self.class.get(*args))
          Hashie::Extensions::SymbolizeKeys.symbolize_keys!(response)
          response
        end
      end
    end
  end
end
