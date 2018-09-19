require 'dry-struct'
require 'dry-types'
require 'host_status/types'
require 'host_status/application'
require 'host_status/resources'

module HostStatus
  # {
  #   "id":                  90952626,
  #   "application_name":    "G3 Homebase Production",
  #   "host":                "crn001-a.prod.homebase.systems",
  #   "language":            "ruby",
  #   "health_status":       "green",
  #   "application_summary": {
  #       "response_time":  0,
  #       "throughput":     0,
  #       "error_rate":     0,
  #       "apdex_score":    null,
  #       "instance_count": 3
  #   },
  #
  class Host < ::Dry::Struct
    attribute :name, HostStatus::Types::Strict::String
    attribute :id, HostStatus::Types::Strict::String.optional
    attribute :resources, HostStatus::Resources
    attribute :applications, Types::Strict::Array.of(HostStatus::Application).default([])
  end
end

