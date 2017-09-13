# Micro::Finances

Micro::Finances is a Rails engine that allows to create simple financial
control - a "must have" feature of almost all information systems for small
companies.

Our objective is to facilitate the development of some features like to record
revenues/costs, cashflow and charging.

## Usage

After install the gem and run its the migrations you will have a model called
Payment available to record the incomes and costs of the company.

The Payment model has the following attributes:
* description: the description of payment, like: "References contract number
  103"
* effect: to inform if it's a revenue or a costs
* due date: the date when the payment should be realized
* due value: the value that should be paid 
* payment date: the date when the payment was realized
* payment value: the value realized
* payable: a polymorphic association that you can use it, for example, to
  associate the payment to a Contract or a Client.

With this you can start creating payments:

```ruby
salary = Payment.new
salary.effect      = :revenue # default value: :revenue
salary.description = "Salary of September, 2016"
salary.due_date    = Date.new(2016, 9, 5)
salary.due_value   = 8_000
salary.save

energy = Payment.new
energy.effect        = :cost
energy.description   = 'Energy bill'
energy.due_date      = Date.new(2016, 9, 10)
energy.due_value     = 300
energy.payment_date  = Date.new(2016, 9, 9)
energy.payment_value = 300
energy.save
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micro-finances', github: 'castroebarros/micro-finances'
```

And then execute:
```bash
$ bundle
```

Copy the migrations into your project:
```bash
$ rails micro_finances:install:migrations
```

And then run:
```bash
$ rake db:migrate
```

## Integrating with models

Payment has a polymorphic association that allows you to add payment to any
model you need. This way you can use it, for example, on Project, Invoice,
Client, etc.

```ruby
class Client < ApplicationRecord
  has_many :payments, as: :payable
end
```

## Integrating with views

Add this entry in your application.js manifest:

```
//= require micro/finances/payments
```

In your view:

```
<%= link_to "New Payment", 
            new_payment_path(
              payable_id: @client, 
              payable_type: "Client", 
              return_to: request.url
            ),
            class: 'btn btn-default btn-xs pull-right' %>
```

The `return_to` parameter is responsible to indicate witch is the next page you
would like to be redirected after save the payment.



## Handling taxes of revenues

Micro::Finances is able to calculate interests and penalties of late payments.
To use this feature, you need to enable the configuration in a initializer
file, like config/initializers/micro_finances.rb:

```
Payment.config.merge!({ 
  :interest_enabled => true,  # default: false
  :interest_rate    => 0.7,   # Rate used to calculate the interest value based on due value.
  :penalty_daily    => 0.75   # Amount of money increased every day as dialy penalty.
})
```

## Contributing

When you clone this project you will need to create the test database before
to run the tests.

```bash
rake db:reset RAILS_ENV=test
rake test
```

## License
The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
