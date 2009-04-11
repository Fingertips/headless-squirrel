require File.expand_path('../../test_helper', __FILE__)

describe "JSTestSan::TestCase" do
  before do
    @test_case = JSTestSan::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), self)
  end
  
  it "should initialize with a html file and delegate" do
    @test_case.html_file.should == fixture('a_unit_test.html')
    @test_case.delegate.should == self
  end
  
  it "should raise a FileDoesNotExistError if the given html file does not exist" do
    lambda {
      JSTestSan::TestCase.alloc.initWithHTMLFile_delegate('/does/not/exist/test.html', self)
    }.should.raise JSTestSan::TestCase::FileDoesNotExistError
  end
  
  it "should instantiate a WebView with the html file and set itself as the frameLoadDelegate" do
    @test_case.webView.should.be.instance_of OSX::WebView
    @test_case.webView.mainFrameURL.should == "file://#{fixture('a_unit_test.html')}"
    @test_case.webView.frameLoadDelegate.should == @test_case
  end
  
  it "should not have finished yet" do
    @test_case.should.not.be.finished
  end
  
  it "should have set tests, assertions, failures, and errors to zero" do
    @test_case.tests.should      == 0
    @test_case.assertions.should == 0
    @test_case.failures.should   == 0
    @test_case.errors.should     == 0
  end
  
  it "should run the tests" do
    @test_case.expects(:webView)
    @test_case.run
  end
end

describe "JSTestSan::TestCase, when running" do
  before do
    @delegate = mock('delegate')
    @test_case = JSTestSan::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), @delegate)
    run_test_case!
  end
  
  it "should return the DOM document" do
    @test_case.document.should.be.instance_of OSX::DOMHTMLDocument
  end
  
  it "should return the `log' element" do
    @test_case.log.should.be.instance_of OSX::DOMHTMLDivElement
    @test_case.log.className.should == 'logsummary'
  end
  
  it "should return the `loglines' element" do
    @test_case.loglines.should.be.instance_of OSX::DOMHTMLTableSectionElement
    @test_case.loglines.className.should == 'loglines'
  end
  
  it "should register itself as an event handler for DOMSubtreeModified events on the `log' element" do
    @test_case.log.expects(:addEventListener___).with('DOMSubtreeModified', @test_case, true)
    @test_case.webView_didFinishLoadForFrame(nil, nil)
  end
  
  it "should not have finished yet if the inner html of the `log' element is `running...'" do
    @test_case.instance_variable_set(:@finished, nil)
    @test_case.log.stubs(:innerText).returns('running...')
    @test_case.handleEvent
    @test_case.should.not.be.finished
  end
  
  it "should have finished once the inner html of the `log' element is not longer `running...'" do
    @test_case.instance_variable_set(:@finished, nil)
    @test_case.handleEvent
    @test_case.should.be.finished
  end
  
  it "should return the number of tests, assertions, failures, and errors" do
    @test_case.tests.should      == 3
    @test_case.assertions.should == 2
    @test_case.failures.should   == 1
    @test_case.errors.should     == 1
  end
  
  it "should let the delegate know its finished running" do
    @delegate.expects(:test_case_finished).with(@test_case)
    @test_case.handleEvent
  end
  
  private
  
  def run_test_case!
    @test_case.run
    sleep 0.25 while not @test_case.finished?
  end
end