require 'simplecov'
require 'simplecov-gem-adapter'
# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start('gem')

['../lib', './models', '../config'].each do |f|
  $LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), f))
end

require 'vestorforce'
