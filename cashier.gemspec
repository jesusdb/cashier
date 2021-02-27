# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cashier/version'

Gem::Specification.new do |spec|
  spec.name = 'cashier'
  spec.version = Cashier::VERSION
  spec.authors = ['Jesús Di Bari']
  spec.email = ['iijbari@gmail.com']
  spec.summary = 'A cashier app'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.1')

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
