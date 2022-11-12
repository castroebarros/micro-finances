$(function() {
  $('#cp-due-value').click(function() {
    $('#payment_payment_value').val($('#payment_due_value').val());
    return false;
  })
  $('#cp-due-date').click(function() {
    $('#payment_payment_date').val($('#payment_due_date').val());
    return false;
  })
  $('#cp-today-date').click(function() {
    $("#payment_payment_date").val(new Date().toLocaleDateString('en-CA'));
    return false; 
  })
  $('#reset-payment-date').click(function() {
    $('#payment_payment_date').val( '' );
    return false;
  })
  $('#calculate-interest').click(function() {
    $.get('/payments/calculate_interest_and_penalty_values.js', $(this).parents('form').serialize());
    return false;
  })
  $('#payment_due_value, #payment_interest_value, #payment_penalty_value, #payment_discount_value').change(function() {
    $.get('/payments/calculate_payment_value.js', $(this).parents('form').serialize())
    return false;
  })
})
