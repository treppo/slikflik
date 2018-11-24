source 'https://rubygems.org'

ruby '~> 2.5'

gem 'sinatra'
gem 'neography'
gem 'slim'
gem 'multi_json'
gem 'oj'
gem 'faraday'
gem 'typhoeus'
gem 'tilt-jbuilder', require: 'tilt/jbuilder'

group :production, :development do
  gem 'foreman'
end

group :development do
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-bundler'
  gem 'sass'
end

group :development, :test do
  gem 'rake'
end

group :test do
  gem 'minitest'
  gem 'minitest-spec-context'
  gem "rack-test", require: "rack/test"
  gem 'capybara'
  gem 'capybara_minitest_spec'
  gem 'vcr'
  gem 'quacky'
end
