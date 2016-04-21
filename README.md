# Perfecta

[![Build Status](https://travis-ci.org/gary-rafferty/perfecta.png)](https://travis-ci.org/gary-rafferty/perfecta)
[![Coverage Status](https://coveralls.io/repos/gary-rafferty/perfecta/badge.png?branch=master)](https://coveralls.io/r/gary-rafferty/perfecta?branch=master)
[![Code Climate](https://codeclimate.com/github/gary-rafferty/perfecta.png)](https://codeclimate.com/github/gary-rafferty/perfecta)

Ruby client for the Perfect Audience [reporting
api](http://support.perfectaudience.com/knowledgebase/articles/233919-reporting-api)

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

Optional Query Parameters include

| Name          | Type                                                          |
| ------------- |:-------------------------------------------------------------:|
| interval      | ['today','yesterday','last_7_days','last_30_days','lifetime'] |
| start_date    | 'YYYY-MM-DD'                                                  |
| end_date      | 'YYYY-MM-DD'                                                  |
| site_id       | 'the_site_id'                                                 |
| campaign_id   | 'the_site_id'                                                 |

and can be used by supplying a hash e.g.

```ruby
p client.campaign_reports(interval: 'yesterday').inspect
```

### List all Ad Reports

```ruby
p client.ad_reports.inspect
```

Any of the additional query parameters from the above table can be supplied as a hash.

### List all Conversion Reports

```ruby
p client.conversion_reports.inspect
```

Any of the additional query parameters from the above table can be supplied as a hash.

### List all Sites

```ruby
p client.sites.inspect
```

### Show a single Site

```ruby
p client.site('SITE_ID').inspect
```

### List all Campaigns

```ruby
p client.campaigns.inspect
```

### Show a single Campaign

```ruby
p client.campaign('CAMPAIGN_ID').inspect
```

### List all Ads

```ruby
p client.ads.inspect
```

### Show a single Ad

```ruby
p client.ad('AD_ID').inspect
```

### List all Segments

```ruby
p client.segments.inspect
```

### Show a single Segment

```ruby
p client.segment('SEGMENT_ID').inspect
```

### List all Conversions

```ruby
p client.conversions.inspect
```

### Show a single Conversion

```ruby
p client.conversion('CONVERSION_ID').inspect
```

## TODO

1. ~~Flesh out the rest of the API~~
2. ~~Accept query parameters~~
3. Error handling, specifically for when token expires
4. Relationships and delegation between of objects
5. ~~Get rid of all the duplication~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contributors

* [@malachaifrazier](https://github.com/gary-rafferty/perfecta/commits?author=malachaifrazier)
* [@alfie-max](https://github.com/gary-rafferty/perfecta/commits?author=alfie-max)
