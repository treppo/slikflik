source 'https://rubygems.org'

gem 'sinatra'
gem 'neography'
gem 'slim'

group :production, :development do
  gem 'foreman'
end

group :development do
  gem 'guard'
  gem 'guard-minitest'
end

group :development, :test do
  gem 'rake'
end

group :test do
  gem 'coveralls'
  gem 'simplecov'
  gem 'minitest'
  gem "rack-test", require: "rack/test"
end
