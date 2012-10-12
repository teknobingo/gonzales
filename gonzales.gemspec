$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gonzales/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gonzales"
  s.version     = Gonzales::VERSION
  s.authors     = ["Knut I Stenmark"]
  s.email       = ["knut.stenmark@gmail.com"]
  s.homepage    = "https://github.com/teknobingo/gonzales"
  s.summary     = "Gonzales speeds up unit teste when using factory_girl"
  s.description = <<THE_END
  Gonzales makes the best out of factory_girl (FactoryGirl), by allowing you to load the factories into the database before the tests starts. 
  You just have to learn one new keyword - 'speedy'.
THE_END

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0.1"
  s.add_dependency "factory_girl", ">= 2.3.2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
end
