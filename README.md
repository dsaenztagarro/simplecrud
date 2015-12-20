# SimpleCrud

This is the easy way to create CRUDs for Rails controllers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplecrud'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplecrud

Add an initializer to your rails app:

```ruby
# config/initializers/simplecrud.rb
require 'simple_crud/base_controller'
```

## Usage

Create your controllers in this way:

```ruby
class DeviceController < SimpleCrud::BaseController
  default_crud
end
```

You will have available the expected `@device` or `@devices` instance var in
the views.

Case the name of your controller doesn't match the name of the resource associated
you could use also:

```ruby
class MyCustomController < SimpleCrud::BaseController
  crud_for Device
end
```

To check the real code injected into the controllers check the source code: `lib/simple_crud/base_controller`

Available hooks
---------------

- `after_save`
- `after_update_attributes`
- `after_destroy`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/dsaenztagarro/simple_crud/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
