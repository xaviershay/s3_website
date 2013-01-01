require 'rubygems'
require 'bundler'

Bundler.require

require 'aruba/cucumber'
require 'cucumber/rspec/doubles'

# Following from 'aruba/cucumber'
Before do
  @__aruba_original_paths = (ENV['PATH'] || '').split(File::PATH_SEPARATOR)
  ENV['PATH'] = ([File.expand_path('bin')] + @__aruba_original_paths).join(File::PATH_SEPARATOR)
  @aruba_timeout_seconds = 5
end

After do
  ENV['PATH'] = @__aruba_original_paths.join(File::PATH_SEPARATOR)
end
# End of following from 'aruba/cucumber'

Then /^the file "([^"]*)" should contain:$/ do |file, exact_content|
  check_file_content(file, exact_content, true)
end

# Disable colored gem. Its difficult to test output when it contains colored strings.
module Colored
  def colorize(string, options = {})
    string
  end
end
