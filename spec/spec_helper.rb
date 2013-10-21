ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
