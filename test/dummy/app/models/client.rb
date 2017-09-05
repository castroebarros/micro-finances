class Client < ApplicationRecord
  has_many :payments, as: :payable
end
