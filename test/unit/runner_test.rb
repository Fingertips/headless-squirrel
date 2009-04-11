require File.expand_path('../../test_helper', __FILE__)

describe "JSTestSan::Runner" do
  before do
    files = [fixture('a_unit_test.html'), fixture('a_unit_test.html')]
    @runner = JSTestSan::Runner.alloc.initWithHTMLFiles(files)
    
    @runner.test_cases.first.stubs(:run)
    @runner.test_cases.last.stubs(:run)
    OSX::NSApplication.sharedApplication.stubs(:run)
  end
  
  it "should have instantiated a JSTestSan::TestCase for each html file" do
    @runner.test_cases.length.should == 2
    @runner.test_cases.each do |test_case|
      test_case.html_file.should == fixture('a_unit_test.html')
      test_case.delegate.should == @runner
    end
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
    @runner.running.should.not.be.empty
    @runner.test_case_finished(@runner.test_cases.first)
    @runner.running.should.not.be.empty
    @runner.test_case_finished(@runner.test_cases.last)
    @runner.running.should.be.empty
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
end