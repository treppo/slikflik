ENV['RACK_ENV'] = 'test'

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
