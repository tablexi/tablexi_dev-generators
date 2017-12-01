$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tablexi_dev/generators/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tablexi_dev-generators"
  s.version     = TablexiDev::Generators::VERSION
  s.authors     = ["Table XI"]
  s.email       = ["devs@tablexi.com"]
  s.homepage    = "https://www.tablexi.com"
  s.summary     = "Summary of TablexiDev::Generators."
  s.description = "Description of TablexiDev::Generators."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
