require 'rubygems'
require 'test/spec'
require 'mocha'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'headless_squirrel'

FIXTURES = File.expand_path('../fixtures', __FILE__)

module TestHelper
  def fixture(name)
    File.join(FIXTURES, name)
  end
end

Test::Unit::TestCase.send(:include, TestHelper)

Thread.new do
  OSX::NSApplication.sharedApplication.run
end