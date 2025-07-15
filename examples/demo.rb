#!/usr/bin/env ruby

# Demo script for ShiftCare Client Management System
# This script demonstrates the core functionality programmatically

require_relative '../lib/shiftcare'

puts "🚀 ShiftCare Client Management System - Demo Mode"
puts "=" * 60

begin
  # Initialize the application components
  client_manager = ShiftCare::ClientManager.new
  display_manager = ShiftCare::DisplayManager.new

  puts "\n📊 Loading client data..."
  puts "✅ Successfully loaded #{client_manager.total_clients} clients"
  puts "📧 Found #{client_manager.unique_emails} unique email addresses"

  # Demo 1: Search functionality
  puts "\n" + "=" * 60
  puts "🔍 Demo 1: Search Functionality"
  puts "=" * 60

  search_queries = ['john', 'smith', 'alice', 'xyz']
  
  search_queries.each do |query|
    puts "\nSearching for: '#{query}'"
    results = client_manager.search_by_name(query)
    
    if results.empty?
      puts "❌ No results found for '#{query}'"
    else
      puts "✅ Found #{results.length} result(s):"
      results.each_with_index do |client, index|
        puts "   #{index + 1}. #{client['name']} (#{client['email']})"
      end
    end
  end

  # Demo 2: Duplicate email detection
  puts "\n" + "=" * 60
  puts "📧 Demo 2: Duplicate Email Detection"
  puts "=" * 60

  duplicates = client_manager.find_duplicate_emails
  
  if duplicates.empty?
    puts "✅ No duplicate email addresses found!"
  else
    puts "⚠️  Found #{duplicates.length} email(s) with duplicates:"
    duplicates.each do |email, clients|
      puts "\n📧 Email: #{email} (#{clients.length} occurrences)"
      clients.each_with_index do |client, index|
        puts "   #{index + 1}. #{client['name']} (ID: #{client['id']})"
      end
    end
  end

  # Demo 3: Statistics
  puts "\n" + "=" * 60
  puts "📊 Demo 3: Dataset Statistics"
  puts "=" * 60

  display_manager.display_stats(client_manager)

  # Demo 4: Edge cases
  puts "\n" + "=" * 60
  puts "🧪 Demo 4: Edge Cases"
  puts "=" * 60

  puts "\nTesting search with edge cases:"
  
  edge_cases = [nil, '', '   ', 'nonexistent']
  edge_cases.each do |query|
    results = client_manager.search_by_name(query)
    puts "  Query: '#{query.inspect}' -> #{results.length} results"
  end

  puts "\n✅ Demo completed successfully!"
  puts "🎉 All core functionality is working as expected!"

rescue StandardError => e
  puts "\n❌ Demo failed with error: #{e.message}"
  puts "Stack trace: #{e.backtrace.first(5).join("\n")}"
  exit(1)
end 