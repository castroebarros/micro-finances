require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
#  include Engine.routes.url_helpers

  setup do
    @payment = payments(:contract)
    @payable = clients(:google)
  end

  test "should get index" do
    get payments_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { 
        payable_type: 'Client',  
        payable_id:   @payable.id,  
        effect: 'revenue', 
        description: "Website", 
        due_date: Date.today, 
        due_value: 6_000 
      } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { 
      payable_type: 'Client',  
      payable_id:   @payable.id,  
      effect: 'revenue', 
      description: "Website", 
      due_date: Date.today, 
      due_value: 6_000 
    } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
