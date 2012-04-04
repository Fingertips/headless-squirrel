task :default => :test

desc "Run the tests"
task :test do
  sh "ruby -r#{Dir['test/unit/*_test.rb'].join(' -r')} -e ''"
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
