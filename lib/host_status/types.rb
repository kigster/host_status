require 'dry-types'
module HostStatus
  module Types
    include ::Dry::Types.module

    Optional = String.optional.default(nil)
    Url = String.optional.default(nil).constrained format: URI::regexp(%w(http https))
    Percent = Coercible::Float.optional.constrained gteq: 0.0, lteq: 100.0
    Megabyte = Coercible::Float.optional
    RatePerMinute = Coercible::Float.optional.default(nil).constrained gteq: 0.0
    IsUp = Bool.optional.default(nil)
    Count = Coercible::Integer.optional.default(nil).constrained gteq: 0
  end
end
