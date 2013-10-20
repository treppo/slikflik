notification :tmux, display_message: true

guard :minitest do
  watch('slikflik.rb') { 'test/acceptance_test.rb' }
  watch(%r{^test/(.*)\/?(.*)_test\.rb})
  watch(%r{^test/test_helper\.rb}) { 'test' }
end
