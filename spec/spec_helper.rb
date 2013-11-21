ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'coveralls'
Coveralls.wear!

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest-spec-context'

# support test sharing through modules
class Module
  include Minitest::Spec::DSL
end
