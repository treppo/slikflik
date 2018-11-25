guard :minitest, include: [:lib, :spec] do
  watch('slikflik.rb') { :spec }
  watch(%r{^lib/.+\.rb}) { :spec }
  watch(%r{^views/.+}) { :spec }
  watch(%r{^spec/.+\.rb}) { :spec }
end

guard :bundler do
  watch('Gemfile')
end
