b = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara-select2/version'

Gem::Specification.new do |gem|
  gem.name          = "capybara-chooser"
  gem.version       = Capybara::Chooser::VERSION
  gem.authors       = ["Damien SZCZYT"]
  gem.email         = ["damien.szczyt@geniustrade.com"]
  gem.description   = %q{Helper for triggering chooser}
  gem.summary       = ""
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rspec'
  gem.add_dependency 'capybara'
end
