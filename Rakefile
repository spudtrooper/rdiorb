require 'rake/testtask'
require 'bundler/setup'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = Dir.glob( "test/**/test_*.rb" )
end


task :default => :test
