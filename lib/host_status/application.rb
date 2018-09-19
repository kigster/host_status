require 'dry-struct'
require 'host_status/types'

module HostStatus
  class Application < Dry::Struct
    transform_keys(&:to_sym)

    attribute :name, HostStatus::Types::Strict::String
    attribute :id, Types::Optional
    attribute :url, Types::Url
    attribute :api_url, Types::Url
    attribute :language, Types::Optional
    attribute :process_count, Types::Count
    attribute :online, Types::IsUp

    # all numbers are per minute
    attribute :errors, Types::RatePerMinute
    attribute :throughput, Types::RatePerMinute
    attribute :latency_p50, Types::RatePerMinute
    attribute :latency_p90, Types::RatePerMinute

    class Proxy
      attr_accessor :app

      def initialize(**opts, &block)
        options  = transform_arguments(**opts)
        self.app = Application.new(**options, &block)
      end

      def method_missing(method, *args, &block)
        if app&.respond_to?(method)
          app&.send(method, *args, &block)
        else
          super(method, *args, &block)
        end
      end

      def transform_arguments(**opts)
        opts
      end
    end
  end
end

