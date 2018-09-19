require 'hashie'
require 'dry-struct'
require 'host_status/types'
require 'host_status/application'

module HostStatus
  module NewRelic
    class APM < ::HostStatus::Application::Proxy
      DEFAULTS = {
          response_time:  nil,
          error_rate:     nil,
          instance_count: nil,
          apdex_score:    nil,
      }.freeze

      def transform_arguments(**opts)
        Hashie::Extensions::SymbolizeKeys.symbolize_keys!(opts)
        options                 = DEFAULTS.merge(opts)
        options[:latency_p50]   = options.delete(:response_time)
        options[:errors]        = options.delete(:error_rate)
        options[:process_count] = options.delete(:instance_count)
        options
      end
    end
  end
end
