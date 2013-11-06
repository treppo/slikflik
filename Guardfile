notification :tmux, display_message: true

guard :minitest do
  watch('slikflik.rb') { 'spec/acceptance/slikflik_spec.rb' }
  watch('spec/acceptance/application_runner.rb') { 'spec/acceptance/slikflik_spec.rb' }
  watch(%r{^lib/(.+)\.rb}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^spec/(.*)\/?(.*)_spec\.rb})
  watch(%r{^spec/spec_helper\.rb}) { 'spec' }
end

guard 'bundler' do
  watch('Gemfile')
end
