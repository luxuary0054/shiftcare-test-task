require 'colorize'

module ShiftCare
  class DisplayManager
    def initialize
      @separator = '=' * 80
    end

    def display_welcome
      puts "\n#{@separator}".colorize(:cyan)
      puts "🚀 ShiftCare Client Management System".colorize(:cyan).bold
      puts "#{@separator}".colorize(:cyan)
      puts "Welcome! This application helps you manage and search through client data.".colorize(:white)
      puts "Type 'help' to see available commands or 'exit' to quit.\n".colorize(:yellow)
    end

    def display_help
      puts "\n#{@separator}".colorize(:green)
      puts "📋 Available Commands:".colorize(:green).bold
      puts "#{@separator}".colorize(:green)
      
      commands = [
        { cmd: 'search <query>', desc: 'Search clients by name (partial match)' },
        { cmd: 'duplicates', desc: 'Find clients with duplicate email addresses' },
        { cmd: 'stats', desc: 'Show dataset statistics' },
        { cmd: 'help', desc: 'Show this help message' },
        { cmd: 'exit', desc: 'Exit the application' }
      ]

      commands.each do |command|
        puts "  #{command[:cmd].colorize(:yellow)} - #{command[:desc]}"
      end
      puts "\n"
    end

    def display_search_results(results, query)
      puts "\n#{@separator}".colorize(:blue)
      puts "🔍 Search Results for: '#{query}'".colorize(:blue).bold
      puts "#{@separator}".colorize(:blue)

      if results.empty?
        puts "❌ No clients found matching '#{query}'".colorize(:red)
      else
        puts "✅ Found #{results.length} client(s):".colorize(:green)
        puts ""
        
        results.each_with_index do |client, index|
          display_client(client, index + 1)
        end
      end
      puts "\n"
    end

    def display_duplicate_emails(duplicates)
      puts "\n#{@separator}".colorize(:magenta)
      puts "📧 Duplicate Email Analysis".colorize(:magenta).bold
      puts "#{@separator}".colorize(:magenta)

      if duplicates.empty?
        puts "✅ No duplicate email addresses found!".colorize(:green)
      else
        puts "⚠️  Found #{duplicates.length} email(s) with duplicates:".colorize(:yellow)
        puts ""

        duplicates.each do |email, clients|
          puts "📧 Email: #{email.colorize(:cyan)} (#{clients.length} occurrences)".colorize(:yellow)
          clients.each_with_index do |client, index|
            puts "   #{index + 1}. #{client['name']} (ID: #{client['id']})".colorize(:white)
          end
          puts ""
        end
      end
      puts "\n"
    end

    def display_stats(client_manager)
      puts "\n#{@separator}".colorize(:green)
      puts "📊 Dataset Statistics".colorize(:green).bold
      puts "#{@separator}".colorize(:green)
      
      puts "📈 Total Clients: #{client_manager.total_clients}".colorize(:cyan)
      puts "📧 Unique Emails: #{client_manager.unique_emails}".colorize(:cyan)
      puts "🔄 Duplicate Emails: #{client_manager.find_duplicate_emails.length}".colorize(:cyan)
      puts "\n"
    end

    def display_error(message)
      puts "\n❌ Error: #{message}".colorize(:red)
      puts ""
    end

    def display_success(message)
      puts "\n✅ #{message}".colorize(:green)
      puts ""
    end

    def display_goodbye
      puts "\n#{@separator}".colorize(:cyan)
      puts "👋 Thank you for using ShiftCare Client Management System!".colorize(:cyan).bold
      puts "#{@separator}".colorize(:cyan)
      puts "Goodbye! 👋\n".colorize(:white)
    end

    def display_prompt
      print "🔍 ShiftCare > ".colorize(:yellow)
    end

    private

    def display_client(client, index)
      puts "  #{index}. #{client['name']}".colorize(:white).bold
      puts "     📧 Email: #{client['email']}".colorize(:cyan)
      puts "     🆔 ID: #{client['id']}".colorize(:magenta)
      puts "     📅 Created: #{client['created_at']}".colorize(:green) if client['created_at']
      puts ""
    end
  end
end 