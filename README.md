# Micro::Finances

Micro::Finances is a Rails engine that allows to create simple financial
control - a "must have" feature of almost all information systems for small
companies.

Our objective is to facilitate the development of some features like to record
revenues/costs, cashflow and charging.

## Usage

After install the gem and run its the migrations you will have a model called
Micro::Finances::Payment available to record the incomes and costs of the
company.

The Payment model has the following attributes:
* description: the description of payment, like: "References contract of number
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
salary = Micro::Finances::Payment.new
salary.effect      = 'revenue'
salary.description = "Salary of September, 2016"
salary.due_date    = Date.new(2016, 9, 5)
salary.due_value   = 8_000
salary.save

energy = Micro::Finances::Payment.new
energy.effect        = 'costs'
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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
