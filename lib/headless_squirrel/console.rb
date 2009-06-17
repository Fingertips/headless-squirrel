# TODO: Needs converage.
module HeadlessSquirrel
  class Console < OSX::NSObject
    objc_class_method 'isSelectorExcludedFromWebScript:', [:BOOL, :sel]
    def self.isSelectorExcludedFromWebScript(selector)
      selector != 'log:'
    end
    
    objc_class_method 'webScriptNameForSelector:', [:id, :sel]
    def self.webScriptNameForSelector(selector)
      'log' if selector == 'log:'
    end
    
    objc_method 'log:', [:void, :id]
    def log(object)
      puts object.description
    end
  end
end

# For some reason RC looks for the Console class in the OSX namespace.
before, $VERBOSE = $VERBOSE, nil
OSX::Console = HeadlessSquirrel::Console
$VERBOSE = before