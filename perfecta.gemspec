# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perfecta/version'

Gem::Specification.new do |gem|
  gem.name          = "perfecta"
  gem.version       = Perfecta::VERSION
  gem.authors       = ["Gary Rafferty"]
  gem.email         = ["gary.rafferty@gmail.com"]
  gem.description   = %q{Ruby API for the PerfectAudience Reporting API}
  gem.summary       = %q{Ruby APU for the PerfectAudience Reporting API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
