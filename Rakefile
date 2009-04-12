task :default => :test

desc "Run the tests"
task :test do
  sh "specrb -s #{Dir['test/unit/*_test.rb'].join(' ')}"
end

# JSTestSan::Rake::Runner.new :regression do |t|
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
    gemspec.name = "js-test-san"
    gemspec.summary = gemspec.description = "A JavaScript test runner which runs from the comfort of the terminal. OS X only."
    gemspec.email = "eloy.de.enige@gmail.com"
    gemspec.homepage = "http://github.com/alloy/js-test-san/tree/master"
    gemspec.authors = ["Eloy Duran"]
  end
rescue LoadError
end