class Payment < Micro::Finances::ApplicationRecord
  extend Enumerize

  enumerize :effect, in: %w(revenue cost), default: :revenue, predicates: true

  usar_como_dinheiro :due_value
  usar_como_dinheiro :interest_value
  usar_como_dinheiro :penalty_value
  usar_como_dinheiro :discount_value
  usar_como_dinheiro :payment_value

  validates :description, :effect, :due_date, :due_value, presence: true

  scope :revenue,          -> { where(effect: 'revenue') }
  scope :cost,             -> { where(effect: 'cost') }
  scope :paid,             -> { where.not(payment_date: nil) }
  scope :not_paid,         -> { where(payment_date: nil) }

  belongs_to :payable, polymorphic: true 

  def self.default_config
    {
      interest_enabled: false,
      interest_rate:    0.07,
      penalty_dialy:    0.75
    }
  end

  def self.config
    @@cofigurations ||= default_config
  end

  def late?
    return false if due_date.future?
    
    (payment_date and payment_date > due_date)
  end
  
  def paid?
    payment_date != nil
  end

  def calculate_payment_value
    self.payment_value = (self.due_value + self.interest_value + self.penalty_value) - self.discount_value
  end

  def calculate_interest_and_penalty_values
    raise 'This calculation works just for revenues' if cost?
    raise 'Payment date have to be filled'           if payment_date.nil?
    
    late_days = (payment_date - due_date).to_i

    if late_days > 0 and self.class.config[:interest_enabled]
      interest_rate       = self.class.config[:interest_rate]
      penalty_dialy       = self.class.config[:penalty_dialy]

      self.interest_value = (due_value * interest_rate)
      self.penalty_value  = (late_days * penalty_dialy)
    else
      self.interest_value = 0
      self.penalty_value  = 0
    end
    self.calculate_payment_value
  end

end
