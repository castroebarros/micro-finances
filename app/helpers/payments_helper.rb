module PaymentsHelper
  def interest_enabled
    Payment.config[:interest_enabled]
  end
end
