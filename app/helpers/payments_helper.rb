module PaymentsHelper
  def interest_enabled
    Payment.config[:interest_enabled]
  end

  def payment_css_classes(payment)
    classes = []
    classes << payment.effect
    classes << 'late'     if payment.late?
    classes << 'paid'     if payment.paid?
    classes << 'not-paid' if !payment.paid?
    classes.join(' ')
  end
end
