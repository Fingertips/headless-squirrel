require File.expand_path('../../test_helper', __FILE__)

describe "JSTestSan::Runner" do
  before do
    @runner = JSTestSan::Runner.new([fixture('a_unit_test.html')])
  end
  
  it "should initialize with an array of html files" do
    @runner.html_files.should == [fixture('a_unit_test.html')]
  end
  
  it "should raise a FileDoesNotExistError if a given html file does not exist" do
    lambda {
      JSTestSan::Runner.new %w{ /does/not/exist/test.html }
    }.should.raise JSTestSan::FileDoesNotExistError
  end
  
  it "should have instantiated a JSTestSan::TestCase for each html file" do
    @runner.test_cases.should == JSTestSan::TestCase.new()
  end
  
  xit "should run the tests" do
    @runner.expects(:passed).with()
    @runner.run
  end
end