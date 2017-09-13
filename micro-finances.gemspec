$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "micro/finances/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "micro-finances"
  s.version     = Micro::Finances::VERSION
  s.authors     = ["Lucas Castro"]
  s.email       = ["castro.lucas@gmail.com"]
  s.homepage    = "http://www.castroebarros.net/open-source/micro-finances"
  s.summary     = "Provides a simple financial control"
  s.description = "Rails Engine that helps you to create your own financial control with less code."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
