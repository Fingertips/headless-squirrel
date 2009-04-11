require File.expand_path('../../test_helper', __FILE__)

module RunnerTestHelper
  def setup
    files = [fixture('a_unit_test.html'), fixture('a_unit_test.html')]
    @runner = JSTestSan::Runner.alloc.initWithHTMLFiles(files)
    
    @runner.stubs(:puts)
    @runner.test_cases.first.stubs(:run)
    @runner.test_cases.last.stubs(:run)
    
    OSX::NSApplication.sharedApplication.stubs(:run)
    OSX::NSApplication.sharedApplication.stubs(:stop)
  end
end

describe "JSTestSan::Runner" do
  include RunnerTestHelper
  
  it "should have instantiated a JSTestSan::TestCase for each html file" do
    @runner.test_cases.length.should == 2
    @runner.test_cases.each do |test_case|
      test_case.html_file.should == fixture('a_unit_test.html')
      test_case.delegate.should == @runner
    end
  end
  
  it "should not have finished yet" do
    @runner.should.not.be.finished
  end
  
  it "should return the total amount of tests" do
    @runner.test_cases.each { |tc| tc.stubs(:tests).returns(3) }
    @runner.tests.should == 6
  end
  
  it "should return the total amount of assertions" do
    @runner.test_cases.each { |tc| tc.stubs(:assertions).returns(2) }
    @runner.assertions.should == 4
  end
  
  it "should return the total amount of failures" do
    @runner.test_cases.each { |tc| tc.stubs(:failures).returns(1) }
    @runner.failures.should == 2
  end
  
  it "should return the total amount of errors" do
    @runner.test_cases.each { |tc| tc.stubs(:errors).returns(1) }
    @runner.errors.should == 2
  end
  
  it "should run the tests cases and start a runloop" do
    @runner.test_cases.first.expects(:run)
    OSX::NSApplication.sharedApplication.expects(:run)
    @runner.run
  end
  
  it "should keep a `running' stack which contains all test cases that are running" do
    @runner.run
    @runner.running.should == @runner.test_cases
  end
  
  it "should remove a finished test case from the `running' stack" do
    @runner.run
    @runner.test_case_finished(@runner.test_cases.first)
    @runner.running.should == [@runner.test_cases.last]
  end
  
  it "should have finished once the `running' stack is empty" do
    @runner.run
    @runner.test_case_finished(@runner.test_cases.first)
    @runner.test_case_finished(@runner.test_cases.last)
    @runner.should.be.finished
  end
end

describe "JSTestSan::Runner, when finalizing" do
  include RunnerTestHelper
  
  it "should print the total amount of tests, assertions, failures, and errors that have been ran" do
    @runner.test_cases.each do |tc|
      tc.stubs(:tests).returns(3)
      tc.stubs(:assertions).returns(2)
      tc.stubs(:failures).returns(1)
      tc.stubs(:errors).returns(1)
    end
    
    @runner.expects(:puts).with("6 tests, 4 assertions, 2 failures, 2 errors")
    @runner.send(:finalize)
  end
  
  it "should end the runloop" do
    OSX::NSApplication.sharedApplication.expects(:stop).with(@runner)
    @runner.send(:finalize)
  end
end