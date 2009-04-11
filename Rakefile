require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = Dir['test/unit/*_test.rb']
end

# JSTestSan::Rake::Runner.new :regression do |t|
#   t.files = Dir['test/regression/prototype/unit/*.html']
# end

