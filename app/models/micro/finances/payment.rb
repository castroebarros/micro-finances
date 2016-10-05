module Micro::Finances
  class Payment < ApplicationRecord
    validates :description, :due_date, :due_value, presence: true

    scope :revenue,       -> { where(effect: 'revenue') }
    scope :cost,          -> { where(effect: 'cost') }
    scope :open,          -> { where(payment_date: nil) }
    scope :confirmed,     -> { where('payment_date IS NOT NULL') }
    scope :with_interest, -> { where(effect: 'cost') }

    def interest
      if payment_value
        payment_value - due_value
      else
        0
      end
    end
  end
end
