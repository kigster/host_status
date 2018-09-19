require 'dry-struct'
require 'host_status/types'
require 'host_status/application'

module HostStatus
  class Resources < ::Dry::Struct
    attribute :pct_cpu_free, HostStatus::Types::Percent.optional
    attribute :pct_ram_free, HostStatus::Types::Percent.optional
    attribute :pct_disk_free, HostStatus::Types::Percent.optional

    # all sizes are in Megabytes
    attribute :mb_ram_free, HostStatus::Types::Megabyte.optional
    attribute :mb_ram_total, HostStatus::Types::Megabyte.optional
    attribute :mb_disk_free, HostStatus::Types::Megabyte.optional
    attribute :mb_disk_total, HostStatus::Types::Megabyte.optional
  end
end

