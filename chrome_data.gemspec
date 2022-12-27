# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chrome_data/version'

Gem::Specification.new do |spec|
  spec.name          = "chrome_data"
  spec.version       = ChromeData::VERSION
  spec.authors       = ["Jim Ryan"]
  spec.email         = ["jim@room118solutions.com"]
  spec.description   = %q{Provides a ruby interface for Chrome Data's API. Read more about it here: http://www.chromedata.com/}
  spec.summary       = %q{A ruby interface for Chrome Data's API}
  spec.homepage      = "http://github.com/room118solutions/chrome_data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", '>= 5.16'
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "mocha", '>= 2.0'

  spec.add_dependency "symboltable"
  spec.add_dependency "activesupport", '>= 3.0'
  spec.add_dependency "lolsoap", '>= 0.7.0'
end
