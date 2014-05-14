# -*- encoding: utf-8 -*- #

File.expand_path('../lib', __FILE__).tap do |lib|
 $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
end

require 'bizarro/version'

Gem::Specification.new do |s|
  s.name          = 'bizarro'
  s.version       = Bizarro::VERSION
  s.summary       = %q{Bizarro: visual regression testing for RSpec}
  s.description   = %q{Adds visual regression testing to RSpec feature tests.}
  s.authors       = ['Chris Svenningsen']
  s.email         = ['chris@carbonfive.com']
  s.homepage      = 'https://github.com/carbonfive/bizarro'
  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.add_dependency 'rspec'
  s.add_dependency 'chunky_png'
end
