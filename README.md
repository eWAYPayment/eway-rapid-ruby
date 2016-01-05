# eWAY Rapid Ruby Library

[![Latest Version on RubyGems][ico-version]][link-rubygems]
[![Software License][ico-license]](LICENSE.md)
[![Build Status][ico-travis]][link-travis]

A Ruby Gem to integrate with eWAY's Rapid Payment API.

Sign up with eWAY at:
 - Australia:    https://www.eway.com.au/
 - New Zealand:  https://eway.io/nz/
 - UK:           https://eway.io/uk/
 - Hong Kong:    https://eway.io/hk/
 - Malaysia:     https://eway.io/my/
 - Singapore:    https://eway.io/sg/

For testing, get a free eWAY Partner account: https://www.eway.com.au/developers

## Installation

The eWAY Ruby Gem requires Ruby 1.9.3 or better, it also requires the rest-client and json gems.

Add this line to your application's Gemfile:

```ruby
gem 'eway_rapid'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install eway_rapid
```

## Usage

See the [eWAY Rapid API Reference](https://eway.io/api-v3/?ruby) for usage details.

A simple Direct payment:

```ruby
require 'eway_rapid'

api_key = 'Rapid API Key'
password = 'Rapid API Password'
endpoint = 'sandbox'

client = EwayRapid::RapidClient.new(api_key, password, endpoint)

transaction = EwayRapid::Models::Transaction.new
transaction.customer = EwayRapid::Models::Customer.new

card_details = EwayRapid::Models::CardDetails.new
card_details.name = 'Ruby Dev'
card_details.number = '4444333322221111'
card_details.expiry_month = '05'
card_details.expiry_year = '22'
card_details.cvn = '123'
transaction.customer.card_details = card_details

payment_details = EwayRapid::Models::PaymentDetails.new
payment_details.total_amount = 1000
transaction.payment_details = payment_details
transaction.transaction_type = EwayRapid::Enums::TransactionType::PURCHASE

response = client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, transaction)

if response.transaction_status.status?
 puts "Success! ID: #{response.transaction_status.transaction_id.to_s}"
end
```

## Testing

All tests can be run by first installing all dependencies with `bundle install` then running `bundle exec rake`  

## Change log

Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.

[ico-version]: https://img.shields.io/gem/v/eway_rapid.svg?style=flat-square
[ico-license]: https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square
[ico-travis]: https://img.shields.io/travis/eWAYPayment/eway-rapid-ruby/master.svg?style=flat-square

[link-rubygems]: https://rubygems.org/gems/eway_rapid
[link-travis]: https://travis-ci.org/eWAYPayment/eway-rapid-ruby
