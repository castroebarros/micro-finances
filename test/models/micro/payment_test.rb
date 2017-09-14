require 'test_helper'

module Micro::Finances
  class PaymentTest < ActiveSupport::TestCase

    test "Payment.income should return all the incomes" do
      assert_equal [payments(:contract)], Payment.revenue.to_a
    end

    test "Payment.cost should return all the costs" do
      assert_equal [payments(:taxi), payments(:office)], Payment.cost.to_a
    end

    test "Payment.paid should return all with payment_date filled" do
      assert_equal [payments(:taxi), payments(:office)], Payment.paid.to_a
    end

    test "Payment.not_paid should return all with payment_date empty" do
      assert_equal [payments(:contract)], Payment.not_paid.to_a
    end

    test "Payment.late should return all not paid with due date in the past" do
      assert_equal [payments(:contract)], Payment.late.to_a
    end

    test "it should validate presence of description" do
      p = Payment.new
      assert p.invalid?
      assert p.errors[:description].include?("can't be blank")
    end

    test "it should validate presence of due date" do
      p = Payment.new
      assert p.invalid?
      assert p.errors[:due_date].include?("can't be blank")
    end

    test "it should validate presence of due value" do
      p = Payment.new
      assert p.invalid?
      assert p.errors[:due_value].include?("can't be blank")
    end

    test "it should validate presence of effect" do
      p = Payment.new
      p.effect = nil
      assert p.invalid?
      assert p.errors[:effect].include?("can't be blank")
    end

    test "#revenue? should return true when it is a revenue" do
      p = Payment.new effect: 'revenue'
      assert p.revenue?
      assert !p.cost?
    end

    test "#cost? should return true when it is a costs" do
      p = Payment.new effect: 'cost'
      assert p.cost?
      assert !p.revenue?
    end

    test "#paid? should return true when the payment date is set" do
      p = Payment.new
      p.payment_date = Date.today
      assert p.paid?

      p.payment_date = nil
      assert !p.paid?
    end

    test "#late? should return true when the payment_date > due_date" do
      p = Payment.new
      p.due_date     = Date.today
      p.payment_date = Date.today + 1.day
      assert p.late?
    end

    test "#late? should return false due_date is on future" do
      p = Payment.new
      p.due_date = Date.tomorrow
      assert !p.late?
    end

    test "it should be able to associate itself to a any model, like a Client" do
      client = ::Client.new
      payment = payments(:contract)
      payment.payable = client
      payment.save

      assert_equal [payment], client.payments 
    end
  end
end
