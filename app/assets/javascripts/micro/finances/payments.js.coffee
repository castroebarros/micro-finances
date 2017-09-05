jQuery ->

  $('#cp-due-value').click ->
    $('#payment_payment_value').val( $('#payment_due_value').val() )
    false

  $('#cp-due-date').click ->
    $('#payment_payment_date').val( $('#payment_due_date').val() )
    false

  $('#cp-today-date').click ->
    $('#payment_payment_date').val( moment().format('YYYY-MM-DD') )
    false

  $('#reset-payment-date').click ->
    $('#payment_payment_date').val( '' )
    false

  $('#calculate-interest').click ->
    $.get '/payments/calculate_interest_and_penalty_values.js', $(this).parents('form').serialize()
    false

  $('#payment_due_value, #payment_interest_value, #payment_penalty_value, #payment_discount_value').change ->
    $.get '/payments/calculate_payment_value.js', $(this).parents('form').serialize()
    false
