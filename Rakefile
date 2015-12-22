require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList[File.join('test', '**', '*test.rb')]
  t.verbose = true
end

task :gem do
  exec('gem build eway_rapid.gemspec')
end