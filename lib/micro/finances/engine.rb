module Micro
  module Finances
    class Engine < ::Rails::Engine
      isolate_namespace Micro::Finances
    end
  end
end
