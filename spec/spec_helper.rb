ENV['RACK_ENV'] = 'test'

if ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'coveralls'
  Coveralls.wear!
end

require 'vcr_setup'

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest-spec-context'
require 'quacky'

# support test sharing through modules
class Module
  include Minitest::Spec::DSL
end
