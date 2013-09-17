# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pl0compiler/version'

Gem::Specification.new do |spec|
  spec.name          = "pl0compiler"
  spec.version       = Pl0compiler::VERSION
  spec.authors       = ["Andres Arana"]
  spec.email         = ["and2arana@gmail.com"]
  spec.description   = %q{Elementary PL0 compiler to native x86 ELF code}
  spec.summary       = %q{This is an elementary PL0 compiler to native x86 ELF
  code written in ruby, distributed as a gem. You can both use the compiler
  through the included command line tools or invoke it through the API defined
  here.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
