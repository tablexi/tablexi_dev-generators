# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tablexi_dev/generators/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tablexi_dev-generators"
  s.version     = TablexiDev::Generators::VERSION
  s.authors     = ["Table XI"]
  s.email       = ["devs@tablexi.com"]
  s.homepage    = "https://github.com/tablexi/tablexi_dev-generators"
  s.summary     = "A recommended set of generators for Table XI projects.."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.0"

  s.add_development_dependency "rubocop"
  s.add_development_dependency "sqlite3"
end
