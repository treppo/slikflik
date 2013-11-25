source 'https://rubygems.org'

gem 'sinatra'
gem 'neography'
gem 'slim'
gem 'oj', platforms: :ruby
gem 'faraday'
gem 'typhoeus', platforms: :ruby

group :production, :development do
  gem 'foreman'
end

group :development do
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-bundler'
end

group :development, :test do
  gem 'rake'
end

group :test do
  gem 'coveralls'
  gem 'simplecov'
  gem 'minitest'
  gem 'minitest-spec-context'
  gem "rack-test", require: "rack/test"
  gem 'capybara'
  gem 'capybara_minitest_spec'
  gem 'vcr'
end
