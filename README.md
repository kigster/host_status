[![Build Status](https://travis-ci.org/kigster/host_status.svg?branch=master)](https://travis-ci.org/kigster/host_status)

> **Compatible with Ruby 2.3 and later**.

# HostStatus — Work In Progress...

This gem provides a consistent interface for a concept of a host or a container running a particular application. It expresses application throughput, error rate, response time, and host cpu/ram/disk metrics in a consistent way, while allowing various pluggable adapters to aquire the data.

For instance, a NewRelic adapter would query the run-time status of a given host using a REST API call. 

An HAProxy adapter may attempt to connect to the haproxy stats port and fetch the data from there.

Once configured, the client of this gem should be able to reliably fetch various metrics about the host. 

> **MOTIVATION**: This gem is motivated by a concept of a Canary Deployment, where it's important to be able to compare metrics of a "canary" host with new application code to that of the rest of the running servers.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'host_status'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install host_status

## Usage

### Configuration

```ruby
require 'host_status'
require 'host_status/data_sources/new_relic'
require 'host_status/data_sources/data_dog'
require 'host_status/data_sources/ssh'

HostStatus.configure do |c|
  c.data_source(:newrelic) do |s|
    s.api_key = '098902384092384023984'
    s.app_id = 90980349850 
  end
  
  # Primary Data Source means any identical values collected by other datasources
  # are ignored. Their values can still be obtained via @host.data_sources.metric_name 
  c.data_source(:datadog, primary: true) do |s|
    s.api_key = '098902384092384023984'
    s.host = 'web001.prod.example.com'
  end
 
  c.data_source(:ssh) do |s|
    s.private_key = Dir.home + '/.ssh/id_rsa'
    s.public_key = Dir.home + '/.ssh/id_rsa.pub'
  end 
end
    
@host = HostStatus.host(name: 'web001.production.site.com')
@host.collect # [Hash<Key[String], Value[Object]]

# per minute metrics obtained from NewReli
@host.throughput 
# => 35001
@host.errors
# => 43.4
@host.latency_p50 # seconds
# => 0.234 

# From the SSH plugin:
@host.pct_cpu_free
# => 23.4
@host.pct_ram_free
# => 21.3

```   

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec host_status` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, 
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kigster/host_status.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


