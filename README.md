A salesforce api wrapper that makes it easy to create queries for
salesforce and then iterate over items in the response.

to test it out without a rails environment
`irb -Ilib -rvestorforce`
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vestorforce'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vestorforce

## Usage
```
authentication_hash = {
  oauth_token: token,
  instance_url: instance_url,
  refresh_token: refresh_token,
  client_id: client_id,
  client_secret: client_secret
}
```
`client = Vestorforce.client(authentication_hash)`
```
client.campaign_by_name('Vestorly') # to get the id of a campaign by its
name
client.nested_campaigns(campaign_id) # to get the names and ids of the
nested campaigns
client.campaign_members(campaign_id) do |member|
  save_member_to_database(member)
end
```

## Contributing

1. Fork it ( https://github.com/Vestorly/vestorforce/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
