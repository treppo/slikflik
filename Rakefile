require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ['lib', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/**/*_spec.rb']
end

task default: [:test]
