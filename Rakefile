require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
end

desc 'Run all tests and linting'
task :test => [:rubocop, :spec]

desc 'Run tests with coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].invoke
end

desc 'Install dependencies'
task :install do
  puts 'Installing dependencies...'
  system('bundle install')
end

desc 'Setup development environment'
task :setup => [:install] do
  puts 'Setting up development environment...'
  system('chmod +x bin/shiftcare')
  puts 'Setup complete! Run "bundle exec rake test" to verify everything works.'
end

desc 'Clean up temporary files'
task :clean do
  puts 'Cleaning up temporary files...'
  system('rm -rf coverage/')
  system('rm -rf tmp/')
  system('rm -rf log/*.log')
  puts 'Cleanup complete!'
end

desc 'Show project information'
task :info do
  puts 'ShiftCare Client Management System'
  puts '=================================='
  puts "Ruby version: #{RUBY_VERSION}"
  puts "RSpec version: #{RSpec::Version::STRING}"
  puts "Project structure:"
  system('find . -type f -name "*.rb" | head -10')
end 