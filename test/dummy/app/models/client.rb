class Client < ApplicationRecord
  has_many :payments, as: :payable, class_name: Micro::Finances::Payment
end
