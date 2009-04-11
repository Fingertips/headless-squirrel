task :default => :test

desc "Run the tests"
task :test do
  sh "specrb -s #{Dir['test/unit/*_test.rb'].join(' ')}"
end

# JSTestSan::Rake::Runner.new :regression do |t|
#   t.files = Dir['test/regression/prototype/unit/*.html']
# end

