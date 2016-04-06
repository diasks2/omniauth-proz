# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/proz/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-proz"
  spec.version       = Omniauth::Proz::VERSION
  spec.authors       = ["Kevin S. Dias"]
  spec.email         = ["diasks2@gmail.com"]

  spec.summary       = %q{ProZ OAuth2 Strategy for OmniAuth}
  spec.description   = %q{ProZ.com OAuth2 Strategy for OmniAuth}
  spec.homepage      = "https://github.com/diasks2/omniauth-proz"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.2"
end
