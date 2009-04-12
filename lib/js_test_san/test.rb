module JSTestSan
  class TestCase < OSX::NSObject
    class Test
      attr_reader :test_case, :name, :state, :output
      
      def initialize(test_case, name, state, output)
        @test_case, @name, @state, @output = test_case, name, state, output
      end
      
      def to_s
%{#{@state.to_s.capitalize}:
#{@name} (#{@test_case.title}) [#{@test_case.html_file}]:
#{@output}}
      end
    end
  end
end