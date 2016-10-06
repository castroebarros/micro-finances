module Micro::Finances
  class Payment < ApplicationRecord
    validates :description, :effect, :due_date, :due_value, presence: true

    scope :revenue,       -> { where(effect: 'revenue') }
    scope :cost,          -> { where(effect: 'cost') }
    scope :open,          -> { where(payment_date: nil) }
    scope :confirmed,     -> { where('payment_date IS NOT NULL') }
    scope :with_interest, -> { where(effect: 'cost') }

    belongs_to :payable, polymorphic: true 

    def interest
      if payment_value
        payment_value - due_value
      else
        0
      end
    end

    def revenue?
      self.effect == 'revenue'
    end

    def cost?
      self.effect == 'cost'
    end
  end
end
