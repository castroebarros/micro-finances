class Payment < Micro::Finances::ApplicationRecord
  extend Enumerize

  enumerize :effect, in: %w(revenue cost), default: :revenue, predicates: true, scope: true

  usar_como_dinheiro :value
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
  scope :late,             -> { not_paid.where("due_date < ?", Date.today) }

  # Payable is used to create a relationship with other model, like Client,
  # Contract, Project, etc. 
  #
  # In same cases, for example, for costs, you can left it blank. It's why
  # it is not required.
  belongs_to :payable, polymorphic: true, required: false

  before_save :set_calculated_fields

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
    return false if due_date.future? or due_date.today?
    return true  if payment_date.nil?
    return true  if payment_date > due_date
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

  def set_calculated_fields
    # date represents the real date of this payment.
    self.date          = (self.payment_date || self.due_date)

    # value represents the real value of this payment.
    self.value         = self.due_value
    self.value         = self.payment_value if self.payment_date
    self.value         = self.value * -1    if self.effect.cost?

    # period helps to take easy handle the payments monthly. 
    self.period        = self.due_date.strftime('%Y%m')

    # the payment's value need to be blank if its date is not set.
    self.payment_value = nil if self.payment_date.nil?
  end

end
