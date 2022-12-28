# ChromeData

Provides a simple ruby interface for Chrome Data's API. Read more about it here: http://www.chromedata.com/

The wonderful [lolsoap](https://github.com/loco2/lolsoap) gem does most of the heavy lifting.

## Installation

Add this line to your application's Gemfile:

    gem 'chrome_data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chrome_data

## Usage

TODO: Write usage instructions here

## (Re-)Recording VCR Cassettes
You can pass your Chrome Data API credentials via ENV vars (they'll be filtered from the generated VCR cassettes):

```shell
$ ACCOUNT_NUMBER=1234 ACCOUNT_SECRET=foo rake test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
