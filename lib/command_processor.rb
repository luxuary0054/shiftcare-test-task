module ShiftCare
  class CommandProcessor
    def initialize(client_manager, display_manager)
      @client_manager = client_manager
      @display_manager = display_manager
    end

    def process_command(input)
      return if input.nil? || input.strip.empty?

      command_parts = input.strip.split(' ')
      command = command_parts.first.downcase
      arguments = command_parts[1..-1]

      case command
      when 'search'
        handle_search(arguments)
      when 'duplicates'
        handle_duplicates
      when 'stats'
        handle_stats
      when 'help'
        @display_manager.display_help
      when 'exit', 'quit'
        @display_manager.display_goodbye
        exit(0)
      else
        @display_manager.display_error("Unknown command: '#{command}'. Type 'help' for available commands.")
      end
    rescue StandardError => e
      @display_manager.display_error(e.message)
    end

    private

    def handle_search(arguments)
      if arguments.empty?
        @display_manager.display_error("Search command requires a query. Usage: search <query>")
        return
      end

      query = arguments.join(' ')
      results = @client_manager.search_by_name(query)
      @display_manager.display_search_results(results, query)
    end

    def handle_duplicates
      duplicates = @client_manager.find_duplicate_emails
      @display_manager.display_duplicate_emails(duplicates)
    end

    def handle_stats
      @display_manager.display_stats(@client_manager)
    end
  end
end 