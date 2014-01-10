lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acquire/version'

Gem::Specification.new do |spec|
  spec.name         = 'acquire'
  spec.summary      = 'Match cucumber tests to lib files, methods, and classes'
  spec.description  = 'Ever wanted to know which cucumber tests are affected by changing a file?'
  spec.homepage     = 'http://benslaughter.github.io/acquire/'
  spec.version      = Acquire::VERSION
  spec.date         = Acquire::DATE
  spec.license      = 'MIT'

  spec.author       = 'Ben Slaughter'
  spec.email        = 'b.p.slaughter@gmail.com'

  spec.files        = ['README.md', 'LICENSE.md', 'HISTORY.md']
  spec.files        += Dir.glob("lib/**/*.rb")
  spec.require_path = 'lib'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'

  spec.add_runtime_dependency 'hashie'

end