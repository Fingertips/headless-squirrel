require 'osx/cocoa'

module JSTestSan
  class Runner < OSX::NSObject
    attr_reader :test_cases, :running
    
    def initWithHTMLFiles(html_files)
      if init
        @test_cases = []
        @running = []
        
        html_files.each do |file|
          @test_cases << TestCase.alloc.initWithHTMLFile_delegate(file, self)
        end
        
        self
      end
    end
    
    def run
      @test_cases.each do |test_case|
        test_case.run
        @running << test_case
      end
      OSX::NSApplication.sharedApplication.run
    end
    
    def tests;      sum :tests      end
    def assertions; sum :assertions end
    def failures;   sum :failures   end
    def errors;     sum :errors     end
    
    def test_case_finished(test_case)
      @running.delete(test_case)
    end
    
    private
    
    def sum(attr)
      @test_cases.inject(0) { |sum, tc| sum += tc.send(attr) }
    end
  end
end