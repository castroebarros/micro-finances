require 'test_helper'

module Micro::Finances
  class PaymentTest < ActiveSupport::TestCase

    test "Payment.income should return all the incomes" do
      assert_equal [payments(:contract)], Payment.revenue.to_a
    end

    test "Payment.cost should return all the costs" do
      assert_equal [payments(:taxi)], Payment.cost.to_a
    end

    test "Payment.confirmed should return all with payment_date filled" do
      assert_equal [payments(:taxi)], Payment.confirmed.to_a
    end

    test "Payment.open should return all with payment_date empty" do
      assert_equal [payments(:contract)], Payment.open.to_a
    end

    test "Payment.with_interest should return all with interest" do
      assert_equal [payments(:taxi)], Payment.with_interest.to_a
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

    test "#interest should return the difference between due and paid values" do
      p = Payment.new(due_value: 10, payment_value: 15)
      assert_equal 5, p.interest
    end

    test "#interest should return 0 if the due value or the paid value is blank" do
      p = Payment.new(due_value: 10, payment_value: nil)
      assert_equal 0, p.interest
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
