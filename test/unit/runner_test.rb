require File.expand_path('../../test_helper', __FILE__)

module RunnerTestHelper
  def setup
    files = [fixture('a_unit_test.html'), fixture('a_unit_test.html')]
    @runner = HeadlessSquirrel::Runner.alloc.initWithHTMLFiles(files)
    
    @runner.stubs(:puts)
    @runner.stubs(:print)
    @runner.test_cases.first.stubs(:run)
    @runner.test_cases.last.stubs(:run)
    
    OSX::NSApplication.sharedApplication.stubs(:run)
    OSX::NSApplication.sharedApplication.stubs(:terminate)
  end
  
  private
  
  def test_stub(name)
    test_case = HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), stub_everything)
    test_case.stubs(:title).returns("A test case with #{name}")
    HeadlessSquirrel::TestCase::Test.new(test_case, name.to_s, name.to_sym, name.to_s)
  end
end

describe "HeadlessSquirrel::Runner" do
  include RunnerTestHelper
  
  it "should have instantiated a HeadlessSquirrel::TestCase for each html file" do
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
    @runner.run
  end
  
  it "should start a runloop when running the tests" do
    OSX::NSApplication.sharedApplication.expects(:run)
    @runner.run
  end
  
  it "should store the start time" do
    time = Time.now
    Time.stubs(:now).returns(time)
    
    @runner.run
    @runner.instance_variable_get(:@start_time).should == time
  end
  
  it "should keep a `queued' stack which contains all test cases that are running" do
    @runner.run
    @runner.queued.should == @runner.test_cases
  end
  
  it "should remove a finished test case from the `queued' stack" do
    @runner.run
    @runner.test_case_finished(@runner.test_cases.first)
    @runner.queued.should == [@runner.test_cases.last]
  end
  
  it "should have finished once the `queued' stack is empty" do
    @runner.run
    @runner.test_case_finished(@runner.test_cases.first)
    @runner.test_case_finished(@runner.test_cases.last)
    @runner.should.be.finished
  end
  
  it "should return tests that have ran but didn't pass" do
    test_case = stub(:title => 'A test case')
    
    @runner.test_ran(test_stub(:passed))
    @runner.test_ran(test_stub(:failed))
    @runner.test_ran(test_stub(:error))
    
    @runner.did_not_pass.first.name.should == 'failed'
    @runner.did_not_pass.last.name.should == 'error'
  end
  
  it "should print a dot when a test ran and passed" do
    @runner.expects(:print).with('.')
    @runner.test_ran(test_stub(:passed))
  end
  
  it "should print a F when a test ran and failed" do
    @runner.expects(:print).with('F')
    @runner.test_ran(test_stub(:failed))
  end
  
  it "should print an E when a test ran and an error occured" do
    @runner.expects(:print).with('E')
    @runner.test_ran(test_stub(:error))
  end
end

describe "HeadlessSquirrel::Runner, when finalizing" do
  include RunnerTestHelper
  
  def setup
    super
    time = Time.now
    @runner.instance_variable_set(:@start_time, time)
    Time.stubs(:now).returns(time + 2.3)
  end
  
  it "should print the tests that did not pass" do
    test1, test2 = test_stub(:failed), test_stub(:error)
    @runner.test_ran(test1)
    @runner.test_ran(test2)
    
    @runner.expects(:puts).with("\n  1) #{test1}")
    @runner.expects(:puts).with("\n  2) #{test2}")
    @runner.send(:finalize)
  end
  
  it "should print the time it took to run the tests" do
    @runner.expects(:puts).with("Finished in 2.3 seconds.")
    @runner.send(:finalize)
  end
  
  it "should print the total amount of tests, assertions, failures, and errors that have been ran" do
    @runner.test_cases.each do |tc|
      tc.stubs(:tests).returns(3)
      tc.stubs(:assertions).returns(2)
      tc.stubs(:failures).returns(1)
      tc.stubs(:errors).returns(1)
    end
    
    @runner.expects(:puts).with("\n6 tests, 4 assertions, 2 failures, 2 errors")
    @runner.send(:finalize)
  end
  
  it "should terminate the application" do
    OSX::NSApplication.sharedApplication.expects(:terminate).with(@runner)
    @runner.send(:finalize)
  end
end