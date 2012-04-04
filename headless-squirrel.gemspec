Gem::Specification.new do |gem|
  gem.name    = 'headless-squirrel'
  gem.version = '0.5.1'
  gem.date    = '2012-04-04'

  gem.summary = "A command-line JavaScript test runner for the Mac."
  gem.description = "A OS X command line tool to run JavaScript (Prototype) unit tests from the comfort of your terminal."

  gem.authors  = ['Eloy Duran']
  gem.email    = 'eloy.de.enige@gmail.com'
  gem.homepage = 'http://github.com/Fingertips/headless-squirrel/tree/master'

  gem.default_executable = 'jstest'

  gem.add_dependency('rake')
  gem.add_development_dependency('rspec', [">= 2.0.0"])

  gem.extra_rdoc_files = ['README.rdoc']
  gem.has_rdoc = true
  gem.rdoc_options = ["--charset=UTF-8"]

  gem.executables = ['jstest']
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  gem.require_paths = ['lib']
end
