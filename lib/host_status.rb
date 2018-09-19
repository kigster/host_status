require 'dry-configurable'
require 'logger'

module HostStatus
  class << self
    attr_accessor :debug
    attr_writer :logger, :adapters

    alias debug? debug

    def log(lvl = :info, *messages)
      messages.each { |m| logger.send(lvl, m) }
    end

    private

    def logger
      @logger ||= :Logger.new(STDOUT)
    end
  end

  extend ::Dry::Configurable
  setting :adapters, []
end

require_relative 'host_status/version'
require_relative 'host_status/types'
require_relative 'host_status/host'

