# RSpec::Ci::Prettify

Hackathon project designed to make CI output for rspec runs (specifically using knapsack and Github actions) more easily digestable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-ci-prettify'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec-ci-prettify

## Usage

Run rspec with the formatter flag set to the gems formatter

and --force-color which will set the RSpec.configuration.color_enabled? to be always true so ANSI Console code
colour wraps are used properly 

example
```
rspec --force-color --format RSpec::Ci::Prettify::Formatter
```

Screenshot of formatter output (Can also be seen on the repos github actions on master)

<img width="1505" alt="Screenshot 2022-12-05 at 17 46 31" src="https://user-images.githubusercontent.com/76173161/205706328-44bc387c-03cc-4112-a78a-c937557d6bf3.png">

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec-ci-prettify.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
