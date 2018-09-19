[![Build Status](https://travis-ci.org/kigster/host_status.svg?branch=master)](https://travis-ci.org/kigster/host_status)

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

```ruby
    HostStatus.configure do |c|
      c.adapters << :newrelic
    end
    
    HostStatus::NewRelic.configure do |c|
      c.api_key = '092358902850934580'
    end
        
```   

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec host_status` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, 
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kigster/host_status.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


