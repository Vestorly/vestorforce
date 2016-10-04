
Simple way to store warnings and errors affecting users as messages. Stored
messages can be linked to a helpful link so they can read more about the problem

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
`include Vestorforce::Notifiable` in the model you want to have notifications eg. the user model.

To create a notification:
```
Vestorforce.notify(
    @user,
    'this_is_the_action_key',
    context: 'you get some context',
    more_context: 'you get some context',
    even_more_context: 'you get some context'
    )
```

## Contributing

1. Fork it ( https://github.com/Vestorly/vestorforce/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
