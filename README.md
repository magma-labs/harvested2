# Harvested: A Ruby Harvest API V2
[![Build Status](https://travis-ci.org/magma-labs/harvested2.svg?branch=master)](https://travis-ci.org/magma-labs/harvested2)

This is a Ruby wrapper for the [Harvest API V2](https://help.getharvest.com/api-v2)

## Installation

    gem install harvested2

## Requirements
- Personal Access Token or OAuth2 application credentials

You can get them at https://id.getharvest.com/developers

## Examples

```ruby
harvest = Harvest.client(access_token: 'token', account_id: '123')
harvest.projects.all # list out projects

client = Harvest::Client.new(name: "Billable Company LTD.")
client = harvest.clients.create(client)
harvest.clients.find(client.id) # returns a Harvest::Client
```

You can also pass query options in as the last parameter on any object's `all` finder
method, for example to find all the projects for client ID 12345:

```ruby
harvest = Harvest.client(access_token: 'token', account_id: '123')
harvest.projects.all(nil, client: 12345)
```

Note: the first parameter is a User ID field that is optional, but needs to be specified
as nil if not included.

You can pass in any hash of query attributes you wish as per the
[Harvest API V2](https://help.getharvest.com/api-v2) page.

You can find more examples at [Harvested Examples](https://github.com/harvesthq/harvest_api_samples/tree/master/v2)

## Permissions

For most operations you need to be an Admin on the Harvest account. You can do a few select things as a normal user or a project manager, but you will likely get errors.

## Hardy Client

The team at Harvest built a great API, but there are always dangers in writing code that depends on an API. For example: HTTP Timeouts, Occasional Bad Gateways, and Rate Limiting issues need to be accounted for.

Using `Harvested#client` your code needs to handle all these situations. However you can also use `Harvested#hardy_client` which will retry errors and wait for Rate Limit resets.

```ruby
harvest = Harvest.hardy_client(access_token: 'token', account_id: '123')
harvest.projects.all # This will wait for the Rate Limit reset if you have gone over your limit
```

## Ruby support

Harvested's tests currently support Ruby version 2.1+

## Links

* [Harvested Documentation](http://rdoc.info/projects/zmoazeni/harvested)
* [Harvest API Documentation](https://help.getharvest.com/api-v2/)
* [Source Code for Harvested](http://github.com/zmoazeni/harvested)

