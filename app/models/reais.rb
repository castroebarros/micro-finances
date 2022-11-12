class Reais
  def initialize(value)
    @value = value.to_f
  end

  def value
    @value
  end

  def to_s
    ActiveSupport::NumberHelper.number_to_currency(value, unit: '', prefix: '').strip
  end

  def to_f
    value
  end

  delegate :+,  to: :value
  delegate :-,  to: :value
  delegate :*,  to: :value
  delegate :/,  to: :value
  delegate :==, to: :value
  delegate :>,  to: :value
  delegate :>=, to: :value
  delegate :<,  to: :value
  delegate :<=, to: :value

  def self.converter(new_value)
    case new_value
    when Reais then
      new_value
    when String
      if new_value =~ /,\d\d$/ 
        new_value = new_value.gsub('.', '').gsub(',', '.')
      end
      Reais.new(new_value)
    else
      Reais.new(new_value)
    end
  end
end
