require 'osx/cocoa'

module JSTestSan
  class Runner < OSX::NSObject
    attr_reader :test_cases, :queued
    
    def initWithHTMLFiles(html_files)
      if init
        @test_cases = []
        html_files.each do |file|
          @test_cases << TestCase.alloc.initWithHTMLFile_delegate(file, self)
        end
        @queued = @test_cases.dup
        
        $stdout.sync = true
        
        self
      end
    end
    
    def run
      @start_time = Time.now
      @queued.first.run
      OSX::NSApplication.sharedApplication.run
    end
    
    def tests;      sum :tests      end
    def assertions; sum :assertions end
    def failures;   sum :failures   end
    def errors;     sum :errors     end
    
    def test_ran(state)
      print case state
      when :passed
        '.'
      when :failed
        'F'
      when :error
        'E'
      end
    end
    
    def test_case_finished(test_case)
      @queued.delete(test_case)
      @queued.empty? ? finalize : @queued.first.run
    end
    
    def finished?
      @finished
    end
    
    private
    
    def sum(attr)
      @test_cases.inject(0) { |sum, tc| sum += tc.send(attr) }
    end
    
    def finalize
      @finished = true
      puts "\nFinished in #{Time.now - @start_time} seconds."
      puts "\n#{tests} tests, #{assertions} assertions, #{failures} failures, #{errors} errors"
      OSX::NSApplication.sharedApplication.terminate(self)
    end
  end
end