# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailhopper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailhopper"
  s.version     = Mailhopper::VERSION
  s.authors     = ["Dan Gebhardt"]
  s.email       = ["support@cerebris.com"]
  s.homepage    = "https://github.com/cerebris/mailhopper"
  s.summary     = "An ActiveRecord based queue for email storage and delivery."
  s.description = "Mailhopper stores your application's emails in a queue for delayed delivery."

  s.rubyforge_project = "mailhopper"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # If your gem is dependent on a specific version (or higher) of Rails:
  s.add_dependency "rails", ">= 3.1.0.rc5"

  # If your gem contains any jquery-specific javascript:
  # s.add_dependency "jquery-rails"

  # Declare development-specific dependencies:
  s.add_development_dependency "sqlite3"
  # s.add_development_dependency "rspec"
end
