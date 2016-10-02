module Micro
  module Finances
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
