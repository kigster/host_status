require 'dry-configurable'

module HostStatus
  module NewRelic
    extend Dry::Configurable
    setting :api_key, ENV['NEWRELIC_API_KEY'], required: true
  end
end
