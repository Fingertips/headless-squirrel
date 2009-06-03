require "osx/cocoa"
OSX.require_framework 'WebKit'

require 'headless_squirrel/test'

module HeadlessSquirrel
  class TestCase < OSX::NSObject
    class FileDoesNotExistError < StandardError; end
    
    def self.sharedWebView
      @sharedWebView ||= OSX::WebView.alloc.init
    end
    
    RESULTS_REGEXP_KEYS = [:report, :_, :tests, :assertions, :failures, :errors]
    RESULTS_REGEXP = /((\d+) tests, )?(\d+) assertions, (\d+) failures, (\d+) errors\n?/
    
    STATES = %w{ passed failed error }
    
    attr_reader :html_file, :delegate, :title
    attr_reader :tests, :assertions, :failures, :errors
    
    def initWithHTMLFile_delegate(html_file, delegate)
      if init
        raise FileDoesNotExistError, "The file `#{html_file}' does not exist." unless File.exist?(html_file)
        @html_file, @delegate = html_file, delegate
        @tests = @assertions = @failures = @errors = 0
        @title = ''
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
      document.getElementsByClassName('logsummary').item(0) || document.getElementById('logsummary')
    end
    
    def loglines
      document.getElementsByClassName('loglines').item(0) || document.getElementById('loglines')
    end
    
    # Not yet sure why the extra check for log not being nil is necessary.
    # Might be a test only thing.
    def webView_didFinishLoadForFrame(_, __)
      @title = webView.mainFrameTitle.to_s
      [log, loglines].each do |element|
        element.addEventListener___('DOMSubtreeModified', self, true) if element
      end
    end
    
    # Catches resource load errors:
    #
    # webView.resourceLoadDelegate = self
    #
    # def webView_resource_didFailLoadingWithError_fromDataSource(w,r,e,d)
    #   message = "#{e.userInfo['NSLocalizedDescription']}: #{e.userInfo['NSErrorFailingURLStringKey']}"
    #   @delegate.test_ran(Test.new(self, "Unable to load test case", :failed, message))
    #   @delegate.test_case_finished(self)
    # end
    
    # Logs js errors:
    #
    # webView.setUIDelegate(self)
    #
    # def webView_addMessageToConsole(_, msg)
    #   p msg
    # end
    
    def handleEvent(event)
      element = event.target
      
      case element
      when OSX::DOMText
        contents = element.wholeText.to_s
      when OSX::DOMHTMLTableCellElement, OSX::DOMHTMLDivElement
        contents = element.innerText.to_s
      end
      
      if contents
        if result = self.class.parse_result(contents)
          if result[:tests]
            finalize_test_suite(result)
          else
            finalize_test(result)
          end
        end
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
    
    def finalize_test(result)
      last_line = loglines.children.item(loglines.children.length-1)
      log_row = self.class.parse_log_row(last_line)
      
      @delegate.test_ran(Test.new(self, log_row[:name], log_row[:state].to_sym, result[:message]))
    end
    
    def finalize_test_suite(result)
      @finished = true
      @tests, @assertions, @failures, @errors = result[:tests].to_i, result[:assertions].to_i, result[:failures].to_i, result[:errors].to_i
      @delegate.test_case_finished(self)
    end
    
    def self.parse_result(line)
      if match = RESULTS_REGEXP.match(line)
        result = Hash[*RESULTS_REGEXP_KEYS.zip(match.to_a).flatten]
        result[:message] = line.sub(result[:report], '')
        result
      end
    end
    
    def self.parse_log_row(row)
      parts = []
      0.upto(row.children.length-1) do |i|
        parts << row.children.item(i).innerText.to_s.strip
      end
      
      # Recent version of unittest.js
      if STATES.include?(parts.first)
        { :state => parts[0], :name => parts[1] }
      # Older version
      else
        { :state => parts[1], :name => parts[0] }
      end
    end
  end
end