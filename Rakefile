task :default => :test

desc "Run the tests"
task :test do
  sh "ruby #{Dir['test/unit/*_test.rb'].join(' ')}"
end

# HeadlessSquirrel::Rake::Runner.new :regression do |t|
#   t.files = Dir['test/regression/prototype/unit/*.html']
# end

desc "Run all the regression tests"
task :ci do
  sh "./bin/jstest #{Dir['test/regression/**/unit/*_test.html'].join(' ')}"
end

namespace :ci do
  desc "Run the prototype regression tests"
  task :prototype do
    sh "./bin/jstest #{Dir['test/regression/prototype/unit/*_test.html'].join(' ')}"
  end
  
  desc "Run the scriptaculous regression tests"
  task :scriptaculous do
    sh "./bin/jstest #{Dir['test/regression/scriptaculous/unit/*_test.html'].join(' ')}"
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "headless-squirrel"
    gemspec.summary = "A command-line JavaScript test runner for the Mac."
    gemspec.description = "A OS X command line tool to run JavaScript (Prototype) unit tests from the comfort of your terminal."
    gemspec.homepage = "http://github.com/Fingertips/headless-squirrel/tree/master"
    
    gemspec.email = "eloy.de.enige@gmail.com"
    gemspec.authors = ["Eloy Duran"]
  end
rescue LoadError
end

begin
  require 'jewelry_portfolio/tasks'
  JewelryPortfolio::Tasks.new do |p|
    p.account = 'Fingertips'
  end
rescue LoadError
end