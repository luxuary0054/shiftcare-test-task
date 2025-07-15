require_relative 'client_manager'
require_relative 'display_manager'
require_relative 'command_processor'

module ShiftCare
  class Application
    def initialize
      @display_manager = DisplayManager.new
      @client_manager = ClientManager.new
      @command_processor = CommandProcessor.new(@client_manager, @display_manager)
    end

    def run
      @display_manager.display_welcome
      @display_manager.display_help

      loop do
        @display_manager.display_prompt
        input = gets&.chomp
        
        if input.nil?
          puts "\n"
          break
        end

        @command_processor.process_command(input)
      end
    rescue Interrupt
      puts "\n"
      @display_manager.display_goodbye
    rescue StandardError => e
      @display_manager.display_error("Application error: #{e.message}")
      exit(1)
    end
  end
end 