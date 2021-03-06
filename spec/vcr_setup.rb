require "vcr"

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :faraday
  c.filter_sensitive_data("12345") { ENV["TMDB_API_KEY"] }
end
