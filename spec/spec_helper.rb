ENV['RACK_ENV'] = 'test'

if ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'coveralls'
  Coveralls.wear!
end

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest-spec-context'

# support test sharing through modules
class Module
  include Minitest::Spec::DSL
end
