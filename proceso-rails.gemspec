lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'proceso/version'

Gem::Specification.new do |spec|
  spec.name         = "proceso-rails"
  spec.version      = Proceso::VERSION
  spec.authors      = ["Bryan Goines"]
  spec.email        = ["bryann83@gmail.com"]
  spec.description  = %q{Proceso Middleware for Rails}
  spec.summary      = %q{Proceso Middleware for Rails 4}
  spec.homepage     = "https://github.com/bry4n/proceso"
  spec.license      = "MIT"

  spec.files        = Dir["{lib,ext}/**/*.{rb,c,h}"]
  spec.test_files   = Dir["spec/**/*.rb"]

  spec.add_dependency "proceso", "~> 0.2", ">= 0.2.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
