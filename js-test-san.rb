require "osx/cocoa"
OSX.require_framework 'WebKit'

class JSTestRunner < OSX::NSObject
  def initWithFile(file)
    if init
      url = OSX::NSURL.fileURLWithPath(file)
      req = OSX::NSURLRequest.requestWithURL(url)
      @webView = OSX::WebView.alloc.init
      @webView.mainFrame.loadRequest(req)
      @webView.frameLoadDelegate = self
      
      self
    end
  end
  
  def document
    @webView.mainFrameDocument
  end
  
  def log
    @webView.mainFrameDocument.getElementsByClassName('logsummary').item(0)
  end
  
  def webView_didFinishLoadForFrame(webView, frame)
    log.addEventListener___('DOMSubtreeModified', self, true)
    puts "Running `#{document.title}'"
    handleEvent
  end
  
  def handleEvent(event = nil)
    summary = log.innerHTML
    puts "=> #{summary}"
    OSX::NSApplication.sharedApplication.terminate(self) unless summary == 'running...'
  end
end

r = JSTestRunner.alloc.initWithFile(ARGV[0])
OSX::NSApplication.sharedApplication.run