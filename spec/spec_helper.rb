ENV['RACK_ENV'] = 'test'
lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
