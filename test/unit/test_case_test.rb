require File.expand_path('../../test_helper', __FILE__)

describe "HeadlessSquirrel::TestCase, class methods" do
  it "should return a shared WebView instance" do
    HeadlessSquirrel::TestCase.sharedWebView.should.be.instance_of OSX::WebView
  end
end

describe "HeadlessSquirrel::TestCase" do
  before do
    @delegate = stub_everything('delegate')
    @test_case = HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), @delegate)
  end
  
  it "should initialize with a html file and delegate" do
    @test_case.html_file.should == fixture('a_unit_test.html')
    @test_case.delegate.should == @delegate
  end
  
  it "should raise a FileDoesNotExistError if the given html file does not exist" do
    lambda {
      HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate('/does/not/exist/test.html', @delegate)
    }.should.raise HeadlessSquirrel::TestCase::FileDoesNotExistError
  end
  
  it "should instantiate a WebView with the html file and set itself as the frameLoadDelegate" do
    @test_case.webView.should == HeadlessSquirrel::TestCase.sharedWebView
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

describe "HeadlessSquirrel::TestCase, when running" do
  before do
    @delegate = stub_everything('delegate')
    @test_case = HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), @delegate)
    run_test_case!
  end
  
  it "should return the DOM document" do
    @test_case.document.should.be.instance_of OSX::DOMHTMLDocument
  end
  
  it "should have stored the document title" do
    @test_case.title.should == 'A HeadlessSquirrel Unit Test HTML File'
    @test_case.instance_variable_get(:@title).should == 'A HeadlessSquirrel Unit Test HTML File'
  end
  
  it "should return the `log' element" do
    @test_case.log.should.be.instance_of OSX::DOMHTMLDivElement
    @test_case.log.className.should == 'logsummary'
  end
  
  it "should return the `loglines' element" do
    @test_case.loglines.should.be.instance_of OSX::DOMHTMLTableSectionElement
    @test_case.loglines.className.should == 'loglines'
  end
  
  it "should register itself as an event handler for DOMSubtreeModified events on the `log' and `loglines' element" do
    @test_case.log.expects(:addEventListener___).with('DOMSubtreeModified', @test_case, true)
    @test_case.loglines.expects(:addEventListener___).with('DOMSubtreeModified', @test_case, true)
    @test_case.webView_didFinishLoadForFrame(nil, nil)
  end
  
  it "should not have finished yet if the inner html of the `log' element is `running...'" do
    @test_case.instance_variable_set(:@finished, nil)
    @test_case.log.stubs(:innerText).returns('running...')
    @test_case.handleEvent(stubbed_log_event)
    @test_case.should.not.be.finished
  end
  
  it "should have finished once the inner html of the `log' element is not longer `running...'" do
    @test_case.instance_variable_set(:@finished, nil)
    @test_case.handleEvent(stubbed_log_event)
    @test_case.should.be.finished
  end
  
  it "should return the number of tests, assertions, failures, and errors" do
    @test_case.tests.should      == 3
    @test_case.assertions.should == 2
    @test_case.failures.should   == 1
    @test_case.errors.should     == 1
  end
  
  it "should let its delegate know its finished running" do
    @delegate.expects(:test_case_finished).with(@test_case)
    @test_case.handleEvent(stubbed_log_event)
  end
  
  it "should not let its delegate know a test ran if the targets class is not one of passed, failed, or error" do
    @delegate.expects(:test_ran).never
    event = stubbed_loglines_event('passed')
    
    event.target.parentNode.stubs(:className).returns('')
    @test_case.handleEvent(event)
    
    event.target.parentNode.stubs(:className).returns('foo')
    @test_case.handleEvent(event)
  end
  
  it "should not let its delegate know a test ran if the output is still empty" do
    @delegate.expects(:test_ran).never
    String.any_instance.stubs(:sub).returns('')
    @test_case.handleEvent(stubbed_loglines_event('failed'))
  end
  
  it "should let its delegate know a test ran if the targets class is one of passed, failed, or error" do
    @test_case = HeadlessSquirrel::TestCase.alloc.initWithHTMLFile_delegate(fixture('a_unit_test.html'), @delegate)
    
    @delegate.expects(:test_ran).times(3).with do |test|
      test.name.should == case test.state
      when :passed
        'testHelloWorldSuccess'
      when :failed
        'testHelloWorldFailure'
      when :error
        'testHelloWorldError'
      end
      
      test.output.should == case test.state
      when :passed
        ""
      when :failed
        "Failure: assertEqual\nexpected: <'Hello world!'>, actual: <''>"
      when :error
        "TypeError: Value undefined (result of expression this.content.foo) is not object., error=(TypeError: Value undefined (result of expression this.content.foo) is not object.)"
      end
      
      true # for mocha
    end
    
    run_test_case!
  end
  
  private
  
  def run_test_case!
    @test_case.run
    sleep 0.25 while not @test_case.finished?
  end
  
  def stubbed_log_event
    stub('Event', :target => @test_case.log.firstChild)
  end
  
  def stubbed_loglines_event(klass)
    element = @test_case.loglines.getElementsByClassName(klass).item(0).children.item(3)
    element.stubs(:parentNode).returns(@test_case.loglines.getElementsByClassName(klass).item(0))
    stub('Event', :target => element)
  end
end