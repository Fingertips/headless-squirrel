require "osx/cocoa"
OSX.require_framework 'WebKit'

module JSTestSan
  class TestCase < OSX::NSObject
    class FileDoesNotExistError < StandardError; end
    
    def self.sharedWebView
      @sharedWebView ||= OSX::WebView.alloc.init
    end
    
    attr_reader :html_file, :delegate
    attr_reader :tests, :assertions, :failures, :errors
    
    def initWithHTMLFile_delegate(html_file, delegate)
      if init
        raise FileDoesNotExistError, "The file `#{html_file}' does not exist." unless File.exist?(html_file)
        @html_file, @delegate = html_file, delegate
        @tests = @assertions = @failures = @errors = 0
        self
      end
    end
    
    def run
      webView
    end
    
    def finished?
      @finished
    end
    
    def webView
      @webView ||= load_webView
    end
    
    def document
      webView.mainFrame.DOMDocument
    end
    
    def log
      document.getElementsByClassName('logsummary').item(0)
    end
    
    def loglines
      document.getElementsByClassName('loglines').item(0)
    end
    
    # Not yet sure why the extra check for log not being nil is necessary.
    # Might be a test only thing.
    def webView_didFinishLoadForFrame(webView, frame)
      [log, loglines].each do |element|
        element.addEventListener___('DOMSubtreeModified', self, true) if element
      end
    end
    
    def handleEvent(event)
      element = event.target
      case element
      when OSX::DOMText
        finalize unless log.innerText == 'running...'
      else
        klass = element.className
        @delegate.test_ran(klass.to_sym) if %w{ passed failed error }.include?(klass)
      end
    end
    
    private
    
    def load_webView
      url = OSX::NSURL.fileURLWithPath(@html_file)
      req = OSX::NSURLRequest.requestWithURL(url)
      webView = self.class.sharedWebView
      webView.mainFrame.loadRequest(req)
      webView.frameLoadDelegate = self
      webView
    end
    
    RESULTS_REGEXP = /^(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors$/
    
    def finalize
      @finished = true
      results = log.innerText.to_s.scan(RESULTS_REGEXP).first
      @tests, @assertions, @failures, @errors = results.map { |x| x.to_i }
      @delegate.test_case_finished(self)
    end
  end
end