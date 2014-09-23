# Finance

This is a collection of some basic finance formulas, which I will develop as I go through: https://class.coursera.org/compfinance-007

## Installation

Add this line to your application's Gemfile:

    gem 'finance', :git => 'https://github.com/happysquare/finance'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install finance, :git => 'https://github.com/happysquare/finance'

## Usage

require 'finance'
include Finance::AssetReturns #asset return mixins
include Finance::TimeValue #time value mixins



## Contributing

1. Fork it ( https://github.com/[my-github-username]/finance/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
