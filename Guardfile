notification :tmux, display_message: true

guard :minitest do
  watch('slikflik.rb') { 'spec/slikflik_spec.rb' }
  watch(%r{^spec/(.*)\/?(.*)_spec\.rb})
  watch(%r{^spec/spec_helper\.rb}) { 'spec' }
end
