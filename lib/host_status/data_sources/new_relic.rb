require 'dry-configurable'

module HostStatus
  module DataSources
    module NewRelic
      extend Dry::Configurable
      setting :api_key, ENV['NEWRELIC_API_KEY'], required: true
    end
  end
end

require_relative 'new_relic/apm'
