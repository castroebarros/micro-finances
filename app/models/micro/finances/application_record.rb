module Micro
  module Finances
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class    = true
      self.table_name_prefix = 'micro_'
    end
  end
end
