require File.expand_path('../../test_helper', __FILE__)

describe "HeadlessSquirrel::TestCase::Test" do
  before do
    @delegate = stub_everything('delegate')
    @test_case = HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), @delegate)
    @test_case.instance_variable_set(:@title, 'A test case')
    
    @test = HeadlessSquirrel::TestCase::Test.new(@test_case, 'testHelloWorld', :failed, 'did not meet expectation')
  end
  
  it "should initialize with a TestCase, name, state and output" do
    @test.test_case.should == @test_case
    @test.name.should == 'testHelloWorld'
    @test.state.should == :failed
    @test.output.should == 'did not meet expectation'
  end
  
  it "should return a formatted string" do
    @test.to_s.should == %{Failed:
testHelloWorld (A test case) [#{fixture('a_unit_test.html')}]:
did not meet expectation}
  end
end