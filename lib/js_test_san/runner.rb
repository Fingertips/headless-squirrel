module JSTestSan
  class Runner
    attr_reader :html_files
    
    def initialize(html_files)
      @html_files = html_files
      @html_files.each do |file|
        raise FileDoesNotExistError, "The file `#{file}' does not exist." unless File.exist?(file)
      end
    end
  end
end