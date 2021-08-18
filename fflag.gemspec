$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fflag/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fflag"
  s.version     = Fflag::VERSION
  s.authors     = ["Jake Webber"]
  s.email       = ["jake@webbernet.com.au"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 6.0.3"

  s.add_development_dependency "pg"
end
