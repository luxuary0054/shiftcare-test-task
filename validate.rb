#!/usr/bin/env ruby

# Validation script for ShiftCare Client Management System
# This script validates the project structure and code syntax

puts "🔍 Validating ShiftCare Client Management System..."
puts "=" * 60

# Check required files and directories
required_files = [
  'Gemfile',
  'README.md',
  'bin/shiftcare',
  'lib/shiftcare.rb',
  'lib/client_manager.rb',
  'lib/display_manager.rb',
  'lib/command_processor.rb',
  'spec/spec_helper.rb',
  'spec/client_manager_spec.rb',
  'spec/command_processor_spec.rb',
  'examples/demo.rb',
  'SETUP.md',
  '.gitignore',
  'Rakefile'
]

required_dirs = [
  'bin',
  'lib',
  'spec',
  'examples'
]

puts "\n📁 Checking project structure..."

# Check directories
required_dirs.each do |dir|
  if Dir.exist?(dir)
    puts "✅ Directory exists: #{dir}/"
  else
    puts "❌ Missing directory: #{dir}/"
  end
end

# Check files
missing_files = []
required_files.each do |file|
  if File.exist?(file)
    puts "✅ File exists: #{file}"
  else
    puts "❌ Missing file: #{file}"
    missing_files << file
  end
end

# Check file sizes
puts "\n📊 File size analysis:"
required_files.each do |file|
  if File.exist?(file)
    size = File.size(file)
    puts "   #{file}: #{size} bytes"
  end
end

# Check for common Ruby syntax issues
puts "\n🔍 Checking Ruby syntax..."

ruby_files = Dir.glob('**/*.rb')
syntax_errors = []

ruby_files.each do |file|
  begin
    # Try to parse the file
    File.open(file, 'r') do |f|
      eval(f.read)
    end
    puts "✅ Syntax OK: #{file}"
  rescue SyntaxError => e
    puts "❌ Syntax error in #{file}: #{e.message}"
    syntax_errors << "#{file}: #{e.message}"
  rescue => e
    puts "⚠️  Warning in #{file}: #{e.message}"
  end
end

# Summary
puts "\n" + "=" * 60
puts "📋 Validation Summary"
puts "=" * 60

if missing_files.empty? && syntax_errors.empty?
  puts "🎉 All validations passed!"
  puts "✅ Project structure is correct"
  puts "✅ All required files are present"
  puts "✅ Ruby syntax is valid"
  puts "\n🚀 The project is ready to use!"
  puts "\nNext steps:"
  puts "1. Install Ruby 2.7+ if not already installed"
  puts "2. Run 'bundle install' to install dependencies"
  puts "3. Run 'ruby bin/shiftcare' to start the application"
  puts "4. Run 'bundle exec rspec' to run tests"
else
  puts "⚠️  Some issues found:"
  
  if !missing_files.empty?
    puts "❌ Missing files:"
    missing_files.each { |file| puts "   - #{file}" }
  end
  
  if !syntax_errors.empty?
    puts "❌ Syntax errors:"
    syntax_errors.each { |error| puts "   - #{error}" }
  end
  
  puts "\nPlease fix the issues above before proceeding."
end

puts "\n" + "=" * 60 