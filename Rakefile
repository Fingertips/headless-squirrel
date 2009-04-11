task :default => :test

desc "Run the tests"
task :test do
  sh "specrb -s #{Dir['test/unit/*_test.rb'].join(' ')}"
end

# JSTestSan::Rake::Runner.new :regression do |t|
#   t.files = Dir['test/regression/prototype/unit/*.html']
# end

desc "Run the regression tests"
task :ci do
  sh "./bin/jstest #{Dir['test/regression/prototype/unit/*.html'].join(' ')}"
end