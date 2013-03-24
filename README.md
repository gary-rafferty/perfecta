# Perfecta

Ruby client for the Perfect Audience [reporting
api](https://www.perfectaudience.com/docs#data_api_autoopen)

## Installation

Add this line to your application's Gemfile:

    gem 'perfecta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install perfecta

## Usage

### Create a new instance of the Perfecta Client

```ruby
client = Perfecta::Client.new do |c|
  c.email = 'email@ddress'
  c.password = 'password'
end
```

This will exchange the credentials for an API token and use this token
for all subsequent calls.

You can now use the client instance to query the API.

### List all Campaign Reports

```ruby
p client.campaign_reports.inspect
```

### List all Ad Reports

```ruby
p client.ad_reports.inspect
```

### List all Conversion Reports

```ruby
p client.conversion_reports.inspect
```

## TODO

1. Flesh out the rest of the API
2. ~~Accept query parameters~~
3. Error handling, specifically for when token expires
4. Relationships and delegation between of objects

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
